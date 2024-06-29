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
      cs_params = ({
        customer_id: @customer1.id,
        subscription_id: @subscription4.id
      })

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
end
