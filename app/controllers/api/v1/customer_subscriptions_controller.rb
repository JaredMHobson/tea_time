class Api::V1::CustomerSubscriptionsController < ApplicationController
  def create
    customer_subscription = CustomerSubscription.new(cs_params)
    customer_subscription.save!

    render json: CustomerSubscriptionSerializer.new(customer_subscription), status: :created
  end

  private

  def cs_params
    params.require(:customer_subscription).permit(:customer_id, :subscription_id)
  end
end
