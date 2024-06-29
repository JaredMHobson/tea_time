class Subscription < ApplicationRecord
  enum status: [ :disabled, :enabled ]

  has_many :customer_subscriptions
  has_many :customers, through: :customer_subscriptions

  validates :title, :price, :status, :frequency, presence: true
end
