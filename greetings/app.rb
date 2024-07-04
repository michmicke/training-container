require_relative "greeter"
require_relative "visits"

class App < Roda
  plugin :json
  plugin :json_parser

  greeter = Greeter.new
  greeter.enable_old_stager! if ENV.fetch('OLD_STAGER_ENABLED', false)
  visits = Visits.new(base_url: ENV.fetch('VISITS_BACKEND'))

  route do |r|
    r.post "greeting" do
      name = r.params['name'] || 'Visitor'
      count = visits.(name:)

      { greeting: greeter.(name:, count:).strip, count: }
    end
  end
end
