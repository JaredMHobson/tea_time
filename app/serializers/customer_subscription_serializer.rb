class CustomerSubscriptionSerializer
  include JSONAPI::Serializer
  attributes :status

  belongs_to :customer
  belongs_to :subscription

  attribute :title do |object|
    object.subscription.title
  end

  attribute :price do |object|
    object.subscription.price
  end

  attribute :frequency do |object|
    object.subscription.frequency
  end
end
