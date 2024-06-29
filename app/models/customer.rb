class Customer < ApplicationRecord
  has_many :customer_subscriptions
  has_many :subscriptions, through: :customer_subscriptions

  validates :first_name, :last_name, :email, :address, presence: true
  validates :email, uniqueness: true
end
