import gleam/float
import gleam/int
import gleam/json.{object, string}

pub type Param {
  StringParam(name: String, value: String)
  IntParam(name: String, value: Int)
  BlobParam(name: String, value: String)
  FloatParam(name: String, value: Float)
  NullParam(name: String)
}

pub fn param_to_json(param: Param) {
  object([
    #("name", string(param.name)),
    #(
      "value",
      object([
        #("type", string(get_param_type(param))),
        #("value", string(get_param_string_value(param))),
      ]),
    ),
  ])
}

fn get_param_type(param: Param) {
  case param {
    StringParam(_, _) -> "text"
    IntParam(_, _) -> "integer"
    BlobParam(_, _) -> "blob"
    FloatParam(_, _) -> "float"
    NullParam(_) -> "null"
  }
}

fn get_param_string_value(param: Param) {
  case param {
    StringParam(_, value) -> value
    IntParam(_, value) -> int.to_string(value)
    BlobParam(_, value) -> value
    FloatParam(_, value) -> float.to_string(value)
    NullParam(_) -> "null"
  }
}
