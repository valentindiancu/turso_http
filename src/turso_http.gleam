import gleam/dynamic.{type Dynamic}
import gleam/http.{Post}
import gleam/http/request
import gleam/httpc
import turso_http/query.{type Query}

pub opaque type Client {
  Client(database_url: String, auth_token: String)
}

pub fn create_client(database_url: String, auth_token: String) -> Client {
  Client(database_url, auth_token)
}

pub fn health_check(client: Client) -> Bool {
  case request.to(client.database_url <> "/health") {
    Ok(req) ->
      case httpc.send(req) {
        Ok(res) if res.status == 200 -> True
        _ -> False
      }
    Error(_) -> False
  }
}

pub fn version(client: Client) -> Result(String, Dynamic) {
  case request.to(client.database_url <> "/version") {
    Ok(req) ->
      case httpc.send(req) {
        Ok(res) if res.status == 200 -> Ok(res.body)
        Ok(_) -> Error(dynamic.from("Database is unhealthy."))
        Error(e) -> Error(e)
      }
    Error(_) ->
      Error(dynamic.from("Failed to create version request. Check database URL"))
  }
}

pub fn query(client: Client, queries: List(Query)) {
  case request.to(client.database_url <> "/v2/pipepline") {
    Ok(req) -> {
      req
      |> request.set_method(Post)
      |> request.set_header("Authorization", "Bearer " <> client.auth_token)
      |> request.set_header("Content-Type", "application/json")
      |> request.set_body(query.query_requests_to_json_string(queries))

      httpc.send(req)
    }
    Error(_) ->
      Error(dynamic.from("Failed to create query request. Check database URL"))
  }
}
