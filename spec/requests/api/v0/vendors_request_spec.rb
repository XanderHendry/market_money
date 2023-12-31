require 'rails_helper'

RSpec.describe 'Vendors Endpoints' do
  describe 'Vendor Show endpoint (/api/v0/vendors/:id)' do
    it 'can get one vendor by its id' do
      id = create(:vendor).id

      get api_v0_vendor_path(id)

      expect(response).to be_successful
      expect(response.status).to eq(200)

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
        get api_v0_vendor_path(99999)

        expect(response).to_not be_successful
        expect(response.status).to eq(404)

        expect(JSON.parse(response.body)).to eq('errors' => [{ 'status' => '404',
                                                               'title' => "Couldn't find Vendor with 'id'=99999" }])
      end
    end
  end
  describe 'Vendor Create endpoint (POST /api/v0/vendors)' do
    it 'can add a Vendor to the api database and returns a 201 status' do
      vendor = build(:vendor)
      post api_v0_vendors_path, params: {
        name: vendor.name,
        description: vendor.description,
        contact_name: vendor.contact_name,
        contact_phone: vendor.contact_phone,
        credit_accepted: vendor.credit_accepted
      }
      expect(response).to be_successful
      expect(response.status).to eq(201)
      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:data][:attributes][:name]).to eq(vendor.name)
      expect(result[:data][:attributes][:description]).to eq(vendor.description)
    end
    describe 'requesting a Vendor be created with incomplete/incorrect data' do
      it 'returns a 400 error with a message' do
        vendor = build(:vendor)
        post api_v0_vendors_path, params: {
          name: '',
          description: vendor.description,
          contact_name: vendor.contact_name,
          contact_phone: vendor.contact_phone,
          credit_accepted: nil
        }
        expect(response).to_not be_successful
        expect(response.status).to eq(400)
        result = JSON.parse(response.body, symbolize_names: true)
        expect(result).to have_key(:errors)
        expect(result[:errors]).to be_a(Array)
        expect(result[:errors].first[:title]).to eq("Validation failed: Name can't be blank, Credit accepted must be true or false")
      end
    end
  end
  describe 'Vendor Update endpoint (PATCH /api/v0/vendors/:id)' do 
    it 'updates the given Vendors information in the api database' do 
      vendor = create(:vendor)
      patch api_v0_vendor_path(vendor.id), params: { contact_name: 'Xander' }
      expect(response).to be_successful
      expect(response.status).to eq(200)
      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:data][:attributes][:name]).to eq(vendor.name)
    end
    describe 'requesting a Vendor be updated with incomplete/incorrect data' do 
      it 'will return a 404 if given an invalid id' do 
        patch api_v0_vendor_path(99999)

        expect(response).to_not be_successful
        expect(response.status).to eq(404)

        expect(JSON.parse(response.body)).to eq('errors' => [{ 'status' => '404',
        'title' => "Couldn't find Vendor with 'id'=99999" }])
      end
      it 'returns a 400 error with a message' do
        vendor = build(:vendor)
        post api_v0_vendors_path, params: {
          name: '',
          description: vendor.description,
          contact_name: vendor.contact_name,
          contact_phone: vendor.contact_phone,
          credit_accepted: nil
        }
        # expect(response).to_not be_successful
        expect(response.status).to eq(400)
        result = JSON.parse(response.body, symbolize_names: true)
        expect(result).to have_key(:errors)
        expect(result[:errors]).to be_a(Array)
        expect(result[:errors].first[:title]).to eq("Validation failed: Name can't be blank, Credit accepted must be true or false")
      end
    end
  end
  describe 'Vendor Delete endpoint (DELETE /api/v0/vendors/:id)' do 
    it 'removes a Vendor from the api database and returns a 204 status' do 
      vendor = create(:vendor)
      delete api_v0_vendor_path(vendor.id)
      expect(response).to be_successful
      expect(response.status).to eq(204)
    end
    describe 'requesting a Vendor be removed with a bad vendor id' do 
      it 'returns a 404 error with a message' do 
        delete api_v0_vendor_path(99999)

        expect(response).to_not be_successful
        expect(response.status).to eq(404)

        expect(JSON.parse(response.body)).to eq('errors' => [{ 'status' => '404',
        'title' => "Couldn't find Vendor with 'id'=99999" }])
      end
    end
  end
end
