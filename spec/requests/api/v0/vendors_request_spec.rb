require 'rails_helper' 

describe 'Vendors Endpoints' do 
  describe 'Vendor Show endpoint (/api/v0/vendors/:id)' do 
    it "can get one vendor by its id" do
      id = create(:vendor).id
    
      get "/api/v0/vendors/#{id}"
    
      vendor = JSON.parse(response.body, symbolize_names: true)
    
      expect(response).to be_successful
    
      expect(vendor).to have_key(:id)
      expect(vendor[:id]).to be_an(Integer)

      expect(vendor).to have_key(:name)
      expect(vendor[:name]).to be_a(String)
    end
    describe 'requesting a vendor not in the database' do 
      it 'returns a 404 error with a message' do
        get "/api/v0/vendors/99999"

        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)).to eq("errors"=>"Couldn't find vendor with 'id'=99999")
      end
    end
  end
end