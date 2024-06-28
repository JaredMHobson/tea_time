class Api::V1::CustomerSubscription < ApplicationRecord
  belongs_to :customer
  belongs_to :subscription

  validates :status, presence: true
end
