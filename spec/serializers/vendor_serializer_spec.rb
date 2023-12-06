require 'rails_helper' 

RSpec.describe VendorSerializer do 
  it 'formats data for a Market object' do 
    vendor = create(:vendor)
    output = VendorSerializer.new(vendor).serializable_hash
    
    expect(output).to have_key(:data)
      expect(output[:data]).to be_an(Hash)

      expect(output[:data]).to have_key(:id)
      expect(output[:data][:id]).to be_an(String)
      
      expect(output[:data]).to have_key(:attributes)
      expect(output[:data][:attributes]).to be_an(Hash)

      expect(output[:data][:attributes]).to have_key(:name)
      expect(output[:data][:attributes][:name]).to be_a(String)

      expect(output[:data][:attributes]).to have_key(:description)
      expect(output[:data][:attributes][:description]).to be_a(String)

      expect(output[:data][:attributes]).to have_key(:contact_name)
      expect(output[:data][:attributes][:contact_name]).to be_a(String)

      expect(output[:data][:attributes]).to have_key(:contact_phone)
      expect(output[:data][:attributes][:contact_phone]).to be_a(String)
  end
end 