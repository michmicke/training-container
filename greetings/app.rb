require_relative "greeter"
require_relative "visits"

class App < Roda
  plugin :json
  plugin :json_parser

  greeter = Greeter.new
  visits = nil
  if ENV.fetch('OLD_STAGER_ENABLED', false)
    greeter.enable_old_stager!
    visits = Visits.new(base_url: ENV.fetch('VISITS_BACKEND'))
  end

  route do |r|
    r.post "greeting" do
      name = r.params['name'] || 'Visitor'
      count = visits && visits.(name:)

      { greeting: greeter.(name:, count:).strip, count: }
    end
  end
end
