class Api::V1::Subscription < ApplicationRecord
  has_many :customer_subscriptions
  has_many :customers, through: :customer_subscriptions

  validates :title, :price, :status, :frequency, presence: true
end
