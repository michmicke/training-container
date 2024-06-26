require "roda"
require "rack/cors"
require_relative "app"

use Rack::Cors do
  allow do
    origins ENV.fetch('CORS_ORIGIN')
    resource '*', headers: :any, methods: [:get, :post]
  end
end

run App.freeze.app

