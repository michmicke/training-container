require_relative "greeter"

class App < Roda
  plugin :json
  plugin :json_parser

  route do |r|
    r.post "greeting" do
      name = r.params['name'] || 'Visitor'
      greeter = Greeter.new

      { greeting: greeter.(name:).strip }
    end
  end
end

