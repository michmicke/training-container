# Dependencies

- ruby
- bundler

# Setup

1. `bundle install`
2. `CORS_ORIGIN=... bin/rackup`

# Usage

```
❯ curl -XPOST 'localhost:9292/greeting' -H 'Content-Type: application/json' -d '{"name":"Theodor"}' -i
HTTP/1.1 200 OK
content-type: application/json
Content-Length: 28

{"greeting":"Hello Theodor","count":1}
```

# Configuration

- use `CORS_ORIGIN` to allow requests from that origin.
- use `OLD_STAGER_ENABLED=1` and `VISITS_BACKEND=http://...` to connect the
  stateful counting backend.
