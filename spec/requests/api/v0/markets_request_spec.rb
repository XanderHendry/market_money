require 'rails_helper'

RSpec.describe 'Markets Endpoints' do
  describe 'Markets Index endpoint (/api/v0/markets)' do
    it 'sends a list of all markets' do
      create_list(:market, 3)

      get api_v0_markets_path

      expect(response).to be_successful
      expect(response.status).to eq(200)

      markets = JSON.parse(response.body, symbolize_names: true)
      expect(markets[:data].count).to eq(3)

      markets[:data].each do |market|
        expect(market).to have_key(:id)
        expect(market[:id]).to be_an(String)

        expect(market).to have_key(:attributes)
        expect(market[:attributes]).to be_an(Hash)

        expect(market[:attributes]).to have_key(:name)
        expect(market[:attributes][:name]).to be_a(String)

        expect(market[:attributes]).to have_key(:street)
        expect(market[:attributes][:street]).to be_a(String)

        expect(market[:attributes]).to have_key(:city)
        expect(market[:attributes][:city]).to be_a(String)

        expect(market[:attributes]).to have_key(:county)
        expect(market[:attributes][:county]).to be_a(String)

        expect(market[:attributes]).to have_key(:state)
        expect(market[:attributes][:state]).to be_a(String)

        expect(market[:attributes]).to have_key(:zip)
        expect(market[:attributes][:zip]).to be_a(String)

        expect(market[:attributes]).to have_key(:lat)
        expect(market[:attributes][:lat]).to be_a(String)

        expect(market[:attributes]).to have_key(:lon)
        expect(market[:attributes][:lon]).to be_a(String)
      end
    end
  end
  describe 'Market Show endpoint (/api/v0/markets/:id)' do
    it 'can get one market by its id' do
      id = create(:market).id

      get api_v0_market_path(id)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      market = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      expect(market).to have_key(:data)
      expect(market[:data]).to be_an(Hash)

      expect(market[:data]).to have_key(:id)
      expect(market[:data][:id]).to be_an(String)

      expect(market[:data]).to have_key(:attributes)
      expect(market[:data][:attributes]).to be_an(Hash)

      expect(market[:data][:attributes]).to have_key(:name)
      expect(market[:data][:attributes][:name]).to be_a(String)

      expect(market[:data][:attributes]).to have_key(:street)
      expect(market[:data][:attributes][:street]).to be_a(String)

      expect(market[:data][:attributes]).to have_key(:city)
      expect(market[:data][:attributes][:city]).to be_a(String)

      expect(market[:data][:attributes]).to have_key(:county)
      expect(market[:data][:attributes][:county]).to be_a(String)

      expect(market[:data][:attributes]).to have_key(:state)
      expect(market[:data][:attributes][:state]).to be_a(String)

      expect(market[:data][:attributes]).to have_key(:zip)
      expect(market[:data][:attributes][:zip]).to be_a(String)

      expect(market[:data][:attributes]).to have_key(:lat)
      expect(market[:data][:attributes][:lat]).to be_a(String)

      expect(market[:data][:attributes]).to have_key(:lon)
      expect(market[:data][:attributes][:lon]).to be_a(String)
    end
    describe 'requesting a Market not in the database' do
      it 'returns a 404 error with a message' do
        get api_v0_market_path(99999)

        expect(response).to_not be_successful
        expect(response.status).to eq(404)

        expect(JSON.parse(response.body)).to eq('errors' => [{ 'status' => '404',
        'title' => "Couldn't find Market with 'id'=99999" }])
      end
    end
  end
  describe 'Market Vendors Index endpoint (/api/v0/markets/:market_id/vendors)' do
    before(:each) do
      @market = create(:market)
      @vendor1 = create(:vendor)
      @vendor2 = create(:vendor)
      @vendor3 = create(:vendor)
      MarketVendor.create({ market_id: @market.id, vendor_id: @vendor1.id })
      MarketVendor.create({ market_id: @market.id, vendor_id: @vendor2.id })
    end
    it 'sends a list of all Vendors that belong to the given Market' do
      get api_v0_market_vendors_path(@market.id)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      market_vendors = JSON.parse(response.body, symbolize_names: true)

      expect(market_vendors[:data].count).to eq(2)

      market_vendors[:data].each do |vendor|
        expect(vendor).to have_key(:id)
        expect(vendor[:id]).to be_an(String)

        expect(vendor).to have_key(:attributes)
        expect(vendor[:attributes]).to be_an(Hash)

        expect(vendor[:attributes]).to have_key(:name)
        expect(vendor[:attributes][:name]).to be_a(String)

        expect(vendor[:attributes]).to have_key(:description)
        expect(vendor[:attributes][:description]).to be_a(String)

        expect(vendor[:attributes]).to have_key(:contact_name)
        expect(vendor[:attributes][:contact_name]).to be_a(String)

        expect(vendor[:attributes]).to have_key(:contact_phone)
        expect(vendor[:attributes][:contact_phone]).to be_a(String)

        expect(vendor[:attributes]).to have_key(:credit_accepted)
        expect(vendor[:attributes][:credit_accepted]).to be(true).or be(false)
      end
    end
    describe 'requesting a Markets vendors with an ID not in the database' do
      it 'returns a 404 error with a message' do
        get api_v0_market_vendors_path(99999)

        expect(response).to_not be_successful
        expect(response.status).to eq(404)

        expect(JSON.parse(response.body)).to eq('errors' => [{ 'status' => '404',
        'title' => "Couldn't find Market with 'id'=99999" }])
      end
    end
  end
  describe 'Market Search endpoint (/api/v0/markets/search)' do 
    it 'will search by city/state/name, city/state, state/name, state, or name' do 
      market = create(:market)
      market2 = create(:market, state: market.state)
      market3 = create(:market, state: market.state, city: market.city)
      
      # search by city/state/name
      get "/api/v0/markets/search?city=#{market.city}&state=#{market.state}&name=#{market.name}"
      expect(response).to be_successful
      expect(response.status).to eq(200)
      search_results = JSON.parse(response.body, symbolize_names: true)
      expect(search_results).to have_key(:data)
      expect(search_results[:data]).to be_an(Array)
      expect(search_results[:data].count).to eq(1)
      
      # search by city/state
      get "/api/v0/markets/search?city=#{market.city}&state=#{market.state}"
      expect(response).to be_successful
      expect(response.status).to eq(200)
      search_results = JSON.parse(response.body, symbolize_names: true)
      expect(search_results).to have_key(:data)
      expect(search_results[:data]).to be_an(Array)
      expect(search_results[:data].count).to eq(2)
      
      # search by state/name
      get "/api/v0/markets/search?state=#{market.state}&name=#{market.name}"
      expect(response).to be_successful
      expect(response.status).to eq(200)
      search_results = JSON.parse(response.body, symbolize_names: true)
      expect(search_results).to have_key(:data)
      expect(search_results[:data]).to be_an(Array)
      expect(search_results[:data].count).to eq(1)
      
      # search by state
      get "/api/v0/markets/search?state=#{market.state}"
      expect(response).to be_successful
      expect(response.status).to eq(200)
      search_results = JSON.parse(response.body, symbolize_names: true)
      expect(search_results).to have_key(:data)
      expect(search_results[:data]).to be_an(Array)
      expect(search_results[:data].count).to eq(3)
      
      # search by name
      get "/api/v0/markets/search?name=#{market.name}"
      expect(response).to be_successful
      expect(response.status).to eq(200)
      search_results = JSON.parse(response.body, symbolize_names: true)
      expect(search_results).to have_key(:data)
      expect(search_results[:data]).to be_an(Array)
      expect(search_results[:data].count).to eq(1)
      
    end
    it 'will return a status of 422 if given bad params, a city+market name only, or a city only' do
      market = create(:market)
      market2 = create(:market, state: market.state)
      market3 = create(:market, state: market.state, city: market.city)
      
      get "/api/v0/markets/search?city=#{market.city}&name=#{market.name}"
      expect(response).to_not be_successful
      expect(response.status).to eq(422)
      
      get "/api/v0/markets/search?city=#{market.city}"
      expect(response).to_not be_successful
      expect(response.status).to eq(422)
      
      get '/api/v0/markets/search?foo=bar'
      expect(response).to_not be_successful
      expect(response.status).to eq(422)
    end
  end
  describe 'ATMs near Market (/api/v0/markets/:id/nearest_atms)' do 
    it 'finds 10 atms near the location of the given market' do 
      market = Market.create({
        name: "14&U Farmers' Market", 
        street:"1400 U Street NW ",
        city: "Washington",
        county: "District of Columbia",
        state: "District of Columbia",
        zip: "20009",
        lat: "38.9169984",
        lon: "-77.0320505"
      })
      get "/api/v0/markets/#{market.id}/nearest_atms"
      
      expect(response).to be_successful
      expect(response.status).to eq(200)
    end
    describe 'requesting a Markets vendors with an ID not in the database' do
      it 'returns a 404 error with a message' do
        get get "/api/v0/markets/9999/nearest_atms"
    
        expect(response).to_not be_successful
        expect(response.status).to eq(404)
    
        expect(JSON.parse(response.body)).to eq('errors' => [{ 'status' => '404',
        'title' => "Couldn't find Market with 'id'=99999" }])
      end
    end
  end
end
