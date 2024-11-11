Web Entrypoint.

`/api/**/*` will be proxied to `http://greetings:9292/...`.
And everything else will be proxied to
`http://frontend:8080/...`.

# Setup

Just copy the `./nginx.conf` to
`/etc/nginx/conf.d/default.conf` and yout should be good to
go.

