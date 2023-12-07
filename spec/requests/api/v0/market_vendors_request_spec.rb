require 'rails_helper' 

RSpec.describe 'MarketVendor Endpoints' do 
  describe 'MarketVendor Create endpoint (POST /api/v0/vendors)' do
    it 'can add a MarketVendor to the api database and returns a 201 status' do
      market = create(:market)
      vendor = create(:vendor)
      post api_v0_vendors_path, params: { market_id: market.id,
                                          vendor_id: vendor.id
                                        }
      
      expect(response).to be_successful
      expect(response.status).to eq(201)
      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:data][:attributes][:market_id]).to eq(market.id)
      expect(result[:data][:attributes][:vendor_id]).to eq(vendor.id)
    end
    describe 'requesting a MarketVendor be created with incomplete/incorrect data' do
      it 'returns a 400 error with a message' do
        vendor = build(:vendor)
        post api_v0_vendors_path, params: { 
          market_id: 99999,
          vendor_id: vendor.id
        }
        expect(response).to_not be_successful
        expect(response.status).to eq(400)
        result = JSON.parse(response.body, symbolize_names: true)
        expect(result).to have_key(:errors)
        expect(result[:errors]).to be_a(Array)
        expect(result[:errors].first[:title]).to eq("Validation failed: Market must exist")
      end
      it 'returns a 422 error with a message' do 
        market_vendor = create(:market_vendor)
        post api_v0_vendors_path, params: { 
          market_id: market_vendor.market.id,
          vendor_id: market_vendor.vendor.id
        }
        expect(response).to_not be_successful
        expect(response.status).to eq(422)
        result = JSON.parse(response.body, symbolize_names: true)
        expect(result).to have_key(:errors)
        expect(result[:errors]).to be_a(Array)
        expect(result[:errors].first[:title]).to eq("Validation failed: Market vendor asociation between market with market_id=#{market_vendor.market.id} and vendor_id=#{market_vendor.vendor.id} already exists")
      end
    end
  end
end 