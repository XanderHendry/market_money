class Vendor < ApplicationRecord
  validates :name, :description, :contact_name, :contact_phone, presence: true
  validate :credit_accepted_validation, on: [:create, :update]

  has_many :market_vendors
  has_many :markets, through: :market_vendors

  private

  def credit_accepted_validation
    errors.add(:credit_accepted, "must be true or false") unless [true, false].include?(self[:credit_accepted])
  end
end