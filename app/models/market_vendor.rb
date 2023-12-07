class MarketVendor < ApplicationRecord
  belongs_to :market
  belongs_to :vendor
  validates :market_id, :vendor_id, presence: true
  validate :unique_market_vendor

  private

  def unique_market_vendor
    market_vendor = MarketVendor.find_by(market_id: self.market_id, vendor_id: self.vendor_id)
    if market_vendor && market_vendor != self
      raise ActiveRecord::RecordNotUnique, "Validation failed: Market vendor asociation between market with market_id=#{self.market_id} and vendor_id=#{self.vendor_id} already exists"
    end
  end
end
