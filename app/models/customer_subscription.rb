class Api::V1::CustomerSubscription < ApplicationRecord
  enum status: [ :cancelled, :active ]

  belongs_to :customer
  belongs_to :subscription

  validates :customer_id, :subscription_id, :status, presence: true
end
