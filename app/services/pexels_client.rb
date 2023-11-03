require 'httparty'

class PexelsClient
  BASE_URL = 'https://api.pexels.com/v1'.freeze

  def initialize(api_key = ENV['PEXELS_API_KEY'])
    @api_key = api_key
  end

  def search_photos(query, per_page: 15)
    response = HTTParty.get(
      "#{BASE_URL}/search",
      query: { query: query, per_page: per_page },
      headers: { 'Authorization' => @api_key }
    )

    response.parsed_response['photos']
  end
end