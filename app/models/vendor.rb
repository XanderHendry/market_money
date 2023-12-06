class Vendor < ApplicationRecord
  validates :name, :description, :contact_name, :contact_phone, :credit_accepted, presence: true
  validates :credit_accepted, inclusion: [true, false]
end