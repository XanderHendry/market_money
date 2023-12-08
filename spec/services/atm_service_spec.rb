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
      end
    end
    context "#get_url" do
      it "returns parsed JSON data" do 
        parsed_response = AtmService.new.get_url("/search/2/poiSearch/atm.json?&limit=10&countryset=District of Columbia&lat=38.9169984&lon=-77.0320505&radius=10000")
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