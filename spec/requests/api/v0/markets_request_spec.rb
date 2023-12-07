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
end
