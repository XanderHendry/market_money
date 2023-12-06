require 'rails_helper' 

describe 'Vendors Endpoints' do 
  describe 'Vendor Show endpoint (/api/v0/vendors/:id)' do 
    it "can get one vendor by its id" do
      id = create(:vendor).id
    
      get "/api/v0/vendors/#{id}"
    
      vendor = JSON.parse(response.body, symbolize_names: true)
    
      expect(response).to be_successful
      expect(response.status).to eq(200)
    
      expect(vendor).to have_key(:data)
      expect(vendor[:data]).to be_an(Hash)

      expect(vendor[:data]).to have_key(:id)
      expect(vendor[:data][:id]).to be_an(String)

      expect(vendor[:data]).to have_key(:attributes)
      expect(vendor[:data][:attributes]).to be_an(Hash)

      expect(vendor[:data][:attributes]).to have_key(:name)
      expect(vendor[:data][:attributes][:name]).to be_a(String)

      expect(vendor[:data][:attributes]).to have_key(:description)
      expect(vendor[:data][:attributes][:description]).to be_a(String)

      expect(vendor[:data][:attributes]).to have_key(:contact_name)
      expect(vendor[:data][:attributes][:contact_name]).to be_a(String)

      expect(vendor[:data][:attributes]).to have_key(:contact_phone)
      expect(vendor[:data][:attributes][:contact_phone]).to be_a(String)

    end
    describe 'requesting a vendor not in the database' do 
      it 'returns a 404 error with a message' do
        get "/api/v0/vendors/99999"

        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)).to eq("errors" => [{"status"=>"404", "title"=>"Couldn't find Vendor with 'id'=99999"}])
      end
    end
  end
end