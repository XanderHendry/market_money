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
      it 'allows the user to search for markets using city, state, and name parameters' do 
        market1 = create(:market)
        market2 = create(:market)
        market3 = create(:market)
        search_results = Market.search_by_fragment(market1.name)
        expect(search_results).to eq(market1)
      end
    end
  end
end
