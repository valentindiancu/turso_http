import gleam/json.{array, object, string}
import gleam/list
import turso_http/param.{type Param, param_to_json}

pub type Query {
  Execute(query: String, params: List(Param))
  Close
}

pub fn query_requests_to_json_string(query_requests: List(Query)) -> String {
  let requests_json = {
    use req <- list.map(query_requests)
    case req {
      Execute(query, params) -> execute_request_json(query, params)
      Close -> close_request_json()
    }
  }

  object([#("requests", array(requests_json, fn(x) { x }))])
  |> json.to_string
}

fn close_request_json() {
  object([#("type", string("close"))])
}

fn execute_request_json(query: String, params: List(Param)) {
  object([
    #("type", string("execute")),
    #(
      "stmt",
      object([
        #("sql", string(query)),
        #("named_args", array(params, param_to_json)),
      ]),
    ),
  ])
}
