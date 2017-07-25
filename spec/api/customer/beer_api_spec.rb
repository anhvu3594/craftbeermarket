require 'rails_helper'

RSpec.describe "CustomerBeerApis", type: :request do
  include_context "customer token"

  context "when customer is authorized" do
    it "load passport and available beers" do
      get "/api/v1/customer_beer", params: {
        token: token
      }

      expect(response).to have_http_status(200)
    end

    context "when consume beer" do
      context "when beer is already in passport" do
        it "do not add beer to passport" do
          beer = FactoryGirl.create(:beer)
          customer.passport.beers << beer

          expect {
            post "/api/v1/customer_beer/consume", params: {
              token: token,
              beer_id: beer.id
            }
          }.to change{ customer.passport.beers.count }.by(0)

          expect(response).to have_http_status(201)
        end
      end

      context "when beer is not in passport" do
        it "add beer to passport" do
          beer = FactoryGirl.create(:beer)
          expect {
            post "/api/v1/customer_beer/consume", params: {
              token: token,
              beer_id: beer.id
            }
          }.to change{ customer.passport.beers.count }.by(1)

          expect(response).to have_http_status(201)
        end
      end
    end
  end
end
