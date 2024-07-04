require 'faraday'

class Visits
  def initialize(base_url:)
    @base_url = base_url
  end

  def call(name:)
    response = client.post('visits', { name: })
    response.body.fetch("visits")
  end

  private

  def client
    Faraday.new(url: @base_url) do |f|
      f.request :json
      f.response :json
      f.response :raise_error
    end
  end
end
