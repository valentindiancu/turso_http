import birdie
import gleeunit
import turso_http/param
import turso_http/query

pub fn main() {
  gleeunit.main()
}

pub fn can_convert_execute_query_request_to_json_test() {
  [query.Execute("SELECT * FROM foo", [])]
  |> query.query_requests_to_json_string()
  |> birdie.snap("execute_query_request_to_json")
}

pub fn can_convert_close_request_to_json_test() {
  [query.Close]
  |> query.query_requests_to_json_string()
  |> birdie.snap("close_request_to_json")
}

pub fn can_convert_multiple_request_to_json_test() {
  [
    query.Execute("SELECT * FROM foo", []),
    query.Execute("SELECT * FROM bar LIMIT :limit", [
      param.IntParam("limit", 10),
    ]),
    query.Close,
  ]
  |> query.query_requests_to_json_string()
  |> birdie.snap("multiple_request_to_json")
}
