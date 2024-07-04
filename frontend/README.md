# Dependencies

- node 20 for building

# Setup

## Development

1. `npm install`
2. `VITE_API_BASE_URL=... npm run dev`

## Build

1. `VITE_API_BASE_URL=... npm install`
2. `npm run build`

The static build is placed in `./dist`.

## Deployment

For nginx there is a working example configuration. Copy `nginx.conf` to
`/etc/nginx/conf.d/`. After copying `./dist` into `/usr/share/nginx/html/` a
standard nginx installation should start responding with the static site
build.


# Configuration

- set `VITE_API_BASE_URL` to the URL where your Greetings API is available.
  This will not be neccessary after exporting the static build.

