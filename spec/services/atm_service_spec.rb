require 'rails_helper' 

RSpec.describe AtmService do 
  context "instance methods" do
    context '#atms_near_market' do
      it 'returns atms near the given market' do 
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
        search = AtmService.new.atms_near_market(market)
        expect(search).to be_a(Hash)
        expect(search[:results]).to be_an(Array)
        expect(search[:results].count).to eq(10)
        atm_data = search[:results].first
        expect(atm_data).to have_key :dist
        expect(atm_data[:dist]).to be_a(Float)
        expect(atm_data).to have_key :poi
        expect(atm_data).to be_a(Hash)
        expect(atm_data[:poi]).to have_key :name
        expect(atm_data[:poi][:name]).to be_a(String)
        expect(atm_data).to have_key :address
        expect(atm_data[:address]).to be_a(Hash)
        expect(atm_data[:address]).to have_key :freeformAddress
        expect(atm_data[:address][:freeformAddress]).to be_a(String) 
        expect(atm_data).to have_key :position
        expect(atm_data[:position]).to be_a(Hash)
        expect(atm_data[:position]).to have_key :lat
        expect(atm_data[:position][:lat]).to be_a(Float)
        expect(atm_data[:position]).to have_key :lon
        expect(atm_data[:position][:lon]).to be_a(Float)
      end
    end
    context "#get_url" do
      it "returns parsed JSON data" do 
        parsed_response = AtmService.new.get_url("/search/2/poiSearch/atm.json?key=#{Rails.application.credentials.tomtom_api[:key]}&limit=10&countryset=US/USA&lat=38.9169984&lon=-77.0320505&radius=10000")
        expect(parsed_response).to be_a Hash
        expect(parsed_response[:results]).to be_an(Array)
      end
    end
    context "#conn" do
      it "returns Faraday object" do
        service = AtmService.new
        expect(service.conn).to be_a(Faraday::Connection)      
      end
    end
  end
end