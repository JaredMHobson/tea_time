require 'rails_helper'

RSpec.describe "CustomerSubscriptions", type: :request do
  before(:each) do
    @customer1 = create(:customer)
    @customer2 = create(:customer)
    @subscription1 = create(:subscription)
    @subscription2 = create(:subscription)
    @subscription3 = create(:subscription)
    @subscription4 = create(:subscription)
  end

  describe "POST customer_subscription" do
    it 'creates a new customer_subscription when a valid customer id and subscription id is passed in the body of the request' do
      cs_params = {
        customer_id: @customer1.id,
        subscription_id: @subscription4.id
      }

      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/customer_subscriptions", headers: headers, params: JSON.generate(customer_subscription: cs_params)

      created_cs = CustomerSubscription.last

      expect(response).to be_successful
      expect(response.status).to eq 201
      expect(created_cs.customer).to eq(@customer1)
      expect(created_cs.subscription).to eq(@subscription4)
      expect(created_cs.status).to eq("active")
    end
  end

  describe "PATCH customer_subscription" do
    it 'updates the customer subscription with the ID in the URI with the new status that is passed in the body and returns the customer subscription' do
      cs1 = CustomerSubscription.create!(customer_id: @customer1.id, subscription_id: @subscription1.id)

      expect(cs1.status).to eq('active')

      cs_params = {
        status: 'cancelled'
      }

      headers = {"CONTENT_TYPE" => "application/json"}

      patch "/api/v1/customer_subscriptions/#{cs1.id}", headers: headers, params: JSON.generate(customer_subscription: cs_params)

      updated_cs1 = CustomerSubscription.find(cs1.id)

      expect(response).to be_successful
      expect(response.status).to eq 200
      expect(updated_cs1.id).to eq(cs1.id)
      expect(updated_cs1.status).to eq('cancelled')
      expect(updated_cs1.customer).to eq(@customer1)
      expect(updated_cs1.subscription).to eq(@subscription1)
    end
  end

  describe "GET all customer_subscriptions" do
    it 'returns all customer_subscriptions for the customer_id passed in the uri' do
      cs1 = CustomerSubscription.create!(customer_id: @customer1.id, subscription_id: @subscription1.id)
      cs2 = CustomerSubscription.create!(customer_id: @customer1.id, subscription_id: @subscription3.id)
      cs3 = CustomerSubscription.create!(customer_id: @customer1.id, subscription_id: @subscription4.id)

      get "/api/v1/customer_subscriptions/#{@customer1.id}"

      customer_subscriptions = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(response).to be_successful
      expect(response.status).to eq 200

      expect(customer_subscriptions.count).to eq(3)
      expect(customer_subscriptions.first[:id]).to eq(cs1.id.to_s)
      expect(customer_subscriptions.first[:relationships][:subscription][:data][:id]).to eq(@subscription1.id.to_s)
      expect(customer_subscriptions.second[:id]).to eq(cs2.id.to_s)
      expect(customer_subscriptions.second[:relationships][:subscription][:data][:id]).to eq(@subscription3.id.to_s)
      expect(customer_subscriptions.last[:id]).to eq(cs3.id.to_s)
      expect(customer_subscriptions.last[:relationships][:subscription][:data][:id]).to eq(@subscription4.id.to_s)

      customer_subscriptions.each do |subscription|
        expect(subscription[:type]).to eq('customer_subscription')
        expect(subscription[:attributes][:status]).to eq('active')
        expect(subscription[:relationships]).to have_key(:customer)
        expect(subscription[:relationships][:customer][:data][:id]).to eq(@customer1.id.to_s)
        expect(subscription[:relationships]).to have_key(:subscription)
      end
    end
  end
end
