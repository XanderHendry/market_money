class AtmService
  def atms_near_market(market)
    get_url("/search/2/poiSearch/atm.json?key=#{Rails.application.credentials.tomtom_api[:key]}&limit=10&countryset=US/USA&lat=#{market.lat}&lon=#{market.lon}&radius=10000")
  end
  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: "https://api.tomtom.com") do |faraday|
      faraday.headers["key"] = Rails.application.credentials.tomtom_api[:key]
    end
  end
end
