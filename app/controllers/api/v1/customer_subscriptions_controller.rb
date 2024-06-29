class Api::V1::CustomerSubscriptionsController < ApplicationController
  def create
    customer_subscription = CustomerSubscription.new(cs_params)
    customer_subscription.save!

    render json: CustomerSubscriptionSerializer.new(customer_subscription), status: :created
  end

  def update
    customer_subscription = CustomerSubscription.find(params[:id])
    customer_subscription.update!(status: params[:customer_subscription][:status])

    render json: CustomerSubscriptionSerializer.new(customer_subscription), status: 200
  end

  private

  def cs_params
    params.require(:customer_subscription).permit(:customer_id, :subscription_id)
  end
end
