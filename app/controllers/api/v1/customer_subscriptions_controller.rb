class Api::V1::CustomerSubscriptionsController < ApplicationController
  def index
    customer = Customer.find(params[:id])

    if params[:status] == 'active'
      render json: CustomerSubscriptionSerializer.new(customer.customer_subscriptions.active), status: 200
    elsif params[:status] == 'cancelled'
      render json: CustomerSubscriptionSerializer.new(customer.customer_subscriptions.cancelled), status: 200
    else
      render json: CustomerSubscriptionSerializer.new(customer.customer_subscriptions), status: 200
    end
  end

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
