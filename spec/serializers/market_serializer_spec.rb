require 'rails_helper' 

RSpec.describe MarketSerializer do 
  it 'formats data for a Market object' do 
    market = create(:market)
    output = MarketSerializer.new(market).serializable_hash
    
    expect(output).to have_key(:data)
      expect(output[:data]).to be_an(Hash)

      expect(output[:data]).to have_key(:id)
      expect(output[:data][:id]).to be_an(String)
      
      expect(output[:data]).to have_key(:attributes)
      expect(output[:data][:attributes]).to be_an(Hash)


      expect(output[:data][:attributes]).to have_key(:name)
      expect(output[:data][:attributes][:name]).to be_a(String)

      expect(output[:data][:attributes]).to have_key(:street)
      expect(output[:data][:attributes][:street]).to be_a(String)

      expect(output[:data][:attributes]).to have_key(:city)
      expect(output[:data][:attributes][:city]).to be_a(String)

      expect(output[:data][:attributes]).to have_key(:county)
      expect(output[:data][:attributes][:county]).to be_a(String)

      expect(output[:data][:attributes]).to have_key(:state)
      expect(output[:data][:attributes][:state]).to be_a(String)

      expect(output[:data][:attributes]).to have_key(:zip)
      expect(output[:data][:attributes][:zip]).to be_a(String)

      expect(output[:data][:attributes]).to have_key(:lat)
      expect(output[:data][:attributes][:lat]).to be_a(String)

      expect(output[:data][:attributes]).to have_key(:lon)
      expect(output[:data][:attributes][:lon]).to be_a(String)
  end
end 