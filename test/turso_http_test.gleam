import dot_env
import dot_env/env
import gleeunit
import gleeunit/should
import turso_http
import turso_http/query.{Close, Execute}

pub fn main() {
  gleeunit.main()
}

fn create_testing_client() {
  dot_env.load()

  turso_http.create_client(
    env.get_or("DATABASE_URL", ""),
    env.get_or("DATABASE_TOKEN", ""),
  )
}

pub fn can_create_client_test() {
  create_testing_client()

  True
  |> should.be_true
}

pub fn can_run_succesful_health_check_test() {
  create_testing_client()
  |> turso_http.health_check
  |> should.be_true
}

pub fn health_check_fails_on_no_url_test() {
  turso_http.create_client("", "")
  |> turso_http.health_check
  |> should.be_false
}

pub fn can_get_version_test() {
  create_testing_client()
  |> turso_http.version
  |> should.be_ok
}

pub fn error_on_version_on_invalid_url_test() {
  turso_http.create_client("", "")
  |> turso_http.version
  |> should.be_error
}

pub fn can_send_query_request_test() {
  let query = Execute("SELECT 1", [])

  create_testing_client()
  |> turso_http.query([query, Close])
  |> should.be_ok
}
