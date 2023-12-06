require 'rails_helper' 

RSpec.describe "Markets Endpoints" do
  describe 'Markets Index endpoint (/api/v0/markets)' do 
      it 'sends a list of all markets' do 
        create_list(:market, 3)
        
        get '/api/v0/markets'

        expect(response).to be_successful

        markets = JSON.parse(response.body, symbolize_names: true)

      expect(markets.count).to eq(3)

      markets.each do |market|
        expect(market).to have_key(:id)
        expect(market[:id]).to be_an(Integer)

        expect(market).to have_key(:name)
        expect(market[:name]).to be_a(String)

        expect(market).to have_key(:street)
        expect(market[:street]).to be_a(String)

        expect(market).to have_key(:city)
        expect(market[:city]).to be_a(String)

        expect(market).to have_key(:county)
        expect(market[:county]).to be_a(String)

        expect(market).to have_key(:state)
        expect(market[:state]).to be_a(String)

        expect(market).to have_key(:zip)
        expect(market[:zip]).to be_a(String)

        expect(market).to have_key(:lat)
        expect(market[:lat]).to be_a(String)

        expect(market).to have_key(:lon)
        expect(market[:lon]).to be_a(String)

      end
    end 
  end 
  describe 'Market Show endpoint (/api/v0/markets/:id)' do 
    it "can get one market by its id" do
      id = create(:market).id
    
      get "/api/v0/markets/#{id}"
    
      market = JSON.parse(response.body, symbolize_names: true)
    
      expect(response).to be_successful
    
      expect(market).to have_key(:id)
      expect(market[:id]).to be_an(Integer)

      expect(market).to have_key(:name)
      expect(market[:name]).to be_a(String)

      expect(market).to have_key(:street)
      expect(market[:street]).to be_a(String)

      expect(market).to have_key(:city)
      expect(market[:city]).to be_a(String)

      expect(market).to have_key(:county)
      expect(market[:county]).to be_a(String)

      expect(market).to have_key(:state)
      expect(market[:state]).to be_a(String)

      expect(market).to have_key(:zip)
      expect(market[:zip]).to be_a(String)

      expect(market).to have_key(:lat)
      expect(market[:lat]).to be_a(String)

      expect(market).to have_key(:lon)
      expect(market[:lon]).to be_a(String)
    end
    describe 'requesting a Market not in the database' do 
      it 'returns a 404 error with a message' do
        get "/api/v0/markets/99999"

        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)).to eq("errors"=>"Couldn't find Market with 'id'=99999")
      end
    end
  end
  describe 'Market Vendors Index endpoint (/api/v0/markets/:market_id/vendors)' do 
    before(:each) do 
      @market = create(:market)
      @vendor1 = create(:vendor)
      @vendor2 = create(:vendor)
      @vendor3 = create(:vendor)
      @vendor4 = create(:vendor)
      market_vendor1 = MarketVendor.create({ market_id: @market.id, vendor_id: @vendor1.id})
      market_vendor2 = MarketVendor.create({ market_id: @market.id, vendor_id: @vendor2.id})
    end
    it 'sends a list of all Vendors that belong to the given Market' do 
      get "/api/v0/markets/#{market.id}/vendors"

      expect(response).to be_successful

      market_vendors = JSON.parse(response.body, symbolize_names: true)

      expect(market_vendors.count).to eq(2)

      market_vendors.each do |vendor|
        expect(vendor).to have_key(:id)
        expect(vendor[:id]).to be_an(Integer)
        expect(vendor).to have_key(:name)
        expect(vendor[:name]).to be_a(String)
        expect(vendor).to have_key(:description)
        expect(vendor[:description]).to be_a(String)
        expect(vendor).to have_key(:contact_name)
        expect(vendor[:contact_name]).to be_a(String)
        expect(vendor).to have_key(:contact_phone)
        expect(vendor[:contact_phone]).to be_a(String)
        expect(vendor).to have_key(:credit_accepted)
        expect(vendor[:credit_accepted]).to be_a(Boolean)
      end
    end
    describe 'requesting a Markets vendors with an ID not in the database' do 
      it 'returns a 404 error with a message' do
        get "/api/v0/markets/99999/vendors"

        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)).to eq("errors"=>"Couldn't find Market with 'id'=99999")
      end
    end
  end
end
