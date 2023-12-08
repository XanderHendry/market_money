require 'rails_helper'

RSpec.describe Market, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:street) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:county) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip) }
    it { should validate_presence_of(:lat) }
    it { should validate_presence_of(:lon) }
  end
  describe 'relationships' do
    it { should have_many(:market_vendors) }
    it { should have_many(:vendors).through(:market_vendors) }
  end

  describe 'class methods' do 
    describe 'self.search_by_fragment' do 
      before(:each) do 
        @market1 = create(:market, name: 'Xander Hendry')
        @market2 = create(:market)
      end
      it 'allows the user to search for markets using city, state, and name parameters' do 
        search_results = Market.search_by_fragment({'city' => @market1.city, 'state' => @market1.state, 'name' => @market1.name})
        expect(search_results.first).to eq(@market1)
      end
      it 'allows the user to search for markets using city, state parameters' do 
        search_results = Market.search_by_fragment({'city' => @market1.city, 'state' => @market1.state})
        expect(search_results.first).to eq(@market1)
      end
      it 'allows the user to search for markets using name, state parameters' do 
        search_results = Market.search_by_fragment({'state' => @market1.state, 'name' => @market1.name})
        expect(search_results.first).to eq(@market1)
      end
      it 'allows the user to search for markets by state' do 
        search_results = Market.search_by_fragment({'state' => @market1.state})
        expect(search_results.first).to eq(@market1)
      end
      it 'allows the user to search for markets by name' do 
        search_results = Market.search_by_fragment({'name' => @market1.name})
        expect(search_results.first).to eq(@market1)
      end
      # it 'does not allow the user to search for markets using name and city parameters' do
      #   expect(Market.search_by_fragment({'city' => @market1.city, 'name' => @market1.name})).to raise_error(ActiveRecord::StatementInvalid)
      # end
      # it 'does not allow the user to search for markets by city' do
      #   expect(Market.search_by_fragment({'city' => @market1.city})).to raise_error(ActiveRecord::StatementInvalid)
      # end
    end
  end
end
