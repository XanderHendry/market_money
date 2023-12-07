require 'rails_helper'

RSpec.describe Vendor, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:contact_name) }
    it { should validate_presence_of(:contact_phone) }
    it 'validates that the value for :credit_accepted is either true or false' do
      vendor1 = build(:vendor, credit_accepted: true)
      vendor2 = build(:vendor, credit_accepted: false)
      vendor3 = build(:vendor, credit_accepted: nil)
      expect(vendor1.valid?).to eq(true)
      expect(vendor2.valid?).to eq(true)
      expect(vendor3.valid?).to eq(false)
    end
  end
  describe 'relationships' do
    it { should have_many(:market_vendors) }
    it { should have_many(:markets).through(:market_vendors) }
  end
end
