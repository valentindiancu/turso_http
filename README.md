# turso_http

[![Package Version](https://img.shields.io/hexpm/v/turso_http)](https://hex.pm/packages/turso_http)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/turso_http/)

Learn more about [Turso](https://docs.turso.tech/introduction)

```sh
gleam add turso_http
```

### Health check
```gleam
import turso_http
import turso_http

pub fn main() {
  turso_http.create_client("{YOUR_DATABASE_URL}", "{YOUR_DATABASE_TOKEN}")
  |> turso_http.health_check
}
```

### Version
```gleam
import turso_http
import turso_http

pub fn main() {
  turso_http.create_client("{YOUR_DATABASE_URL}", "{YOUR_DATABASE_TOKEN}")
  |> turso_http.version
}
```

### SQL Queries
```gleam
import turso_http
import turso_http/query.{Execute, Close}

pub fn main() {
  let query = Execute("SELECT 1", [])


  turso_http.create_client("{YOUR_DATABASE_URL}", "{YOUR_DATABASE_TOKEN}")
  |> turso_http.query([query, Close])
}
```