import birdie
import gleam/json
import gleeunit
import turso_http/param

pub fn main() {
  gleeunit.main()
}

pub fn can_convert_string_param_to_json_test() {
  param.StringParam("foo", "bar")
  |> param.param_to_json
  |> json.to_string
  |> birdie.snap("string_param_to_json")
}

pub fn can_convert_int_param_to_json_test() {
  param.IntParam("foo", 1234)
  |> param.param_to_json
  |> json.to_string
  |> birdie.snap("int_param_to_json")
}

pub fn can_convert_float_param_to_json_test() {
  param.FloatParam("foo", 1234.1234)
  |> param.param_to_json
  |> json.to_string
  |> birdie.snap("float_param_to_json")
}

pub fn can_convert_blob_param_to_json_test() {
  param.BlobParam("foo", "bar")
  |> param.param_to_json
  |> json.to_string
  |> birdie.snap("blob_param_to_json")
}

pub fn can_convert_null_param_to_json_test() {
  param.NullParam("foo")
  |> param.param_to_json
  |> json.to_string
  |> birdie.snap("null_param_to_json")
}
