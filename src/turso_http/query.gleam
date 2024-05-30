import gleam/json.{array, null, object, string}
import gleam/list
import gleam/option.{type Option, None, Some}
import turso_http/param.{type Param, param_to_json}

pub type Query {
  Execute(query: String, params: List(Param))
  Close
}

pub fn query_requests_to_json_string(
  query_requests: List(Query),
  baton baton: Option(String),
) -> String {
  let requests_json = {
    use req <- list.map(query_requests)
    case req {
      Execute(query, params) -> execute_request_json(query, params)
      Close -> close_request_json()
    }
  }

  object([
    #("baton", baton_json(baton)),
    #("requests", array(requests_json, fn(x) { x })),
  ])
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

fn baton_json(baton: Option(String)) {
  case baton {
    None -> null()
    Some(baton) -> string(baton)
  }
}
