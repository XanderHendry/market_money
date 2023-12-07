class Market < ApplicationRecord
  validates :name, :street, :city, :county, :state, :zip, :lat, :lon, presence: true
  has_many :market_vendors
  has_many :vendors, through: :market_vendors

  def self.search_by_fragment(query)
    query_params = query.keys.sort

    if query_params == ['city', 'name', 'state']
      #200?
      market = Market.where(query)
    elsif query_params == ['name', 'state']
      # 200?
      market = Market.where(query)
    elsif query_params == ['city', 'state']
      # 200?
      market = Market.where(query)
    elsif query_params == ['state']
      # 200?
      market = Market.where(query)
    elsif query_params == ['name']
      # 200?
      market = Market.where(query)
    else 
      # 422?
      raise ActiveRecord::StatementInvalid, "Invalid set of parameters. Please provide a valid set of parameters to perform a search with this endpoint."
    end
  end
end
