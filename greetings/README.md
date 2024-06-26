# Dependencies

- ruby
- bundler

# Setup

1. `bundle install`
2. `CORS_ORIGIN=... bundle exec rackup`

# Usage

```
❯ curl -XPOST 'localhost:9292/greeting' -H 'Content-Type: application/json' -d '{"name":"Theodor"}' -i
HTTP/1.1 200 OK
content-type: application/json
Content-Length: 28

{"greeting":"Hello Theodor"}
```

# Configuration

- use `CORS_ORIGIN` to allow requests from that origin.
