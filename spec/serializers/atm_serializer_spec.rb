require 'rails_helper'

RSpec.describe AtmSerializer do
  it 'formats data from the AtmService response' do
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
    response = AtmSerializer.new(AtmService.new.atms_near_market(market))
    output = response.serialize_json
    expect(output).to have_key(:data)
    expect(output[:data]).to be_an(Array)
    
    atm_data = output[:data].first
    expect(atm_data).to have_key(:id)
    expect(atm_data[:id]).to be_nil
    expect(atm_data).to have_key(:type)
    expect(atm_data[:type]).to eq('atm')
    expect(atm_data).to have_key(:attributes)
    expect(atm_data[:attributes]).to be_a(Hash)
    atm_attributes = atm_data[:attributes]
    expect(atm_attributes).to have_key(:name)
    expect(atm_attributes[:name]).to be_a(String)
    expect(atm_attributes).to have_key(:address)
    expect(atm_attributes[:address]).to be_a(String)
    expect(atm_attributes).to have_key(:lat)
    expect(atm_attributes[:lat]).to be_a(Float)
    expect(atm_attributes).to have_key(:lon)
    expect(atm_attributes[:lon]).to be_a(Float)
    expect(atm_attributes).to have_key(:distance)
    expect(atm_attributes[:distance]).to be_a(Float)
  end
end