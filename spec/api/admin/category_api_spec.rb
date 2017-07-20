require 'rails_helper'

RSpec.describe "AdminCategoryApis", type: :request do
  include_context "admin token"
  
  it "load all categories" do
    get "/api/v1/admin_category", params: {
      token: token
    }
    expect(response).to have_http_status(200)
  end

  it "create category" do
    expect {
      post "/api/v1/admin_category/create", params: {
        token: token,
        category: {name: "hello"}
      }
    }.to change(Category, :count).by(1)

    expect(response).to have_http_status(201)
  end

  it "delete category" do
    expect {
      post "/api/v1/admin_category/create", params: {
        token: token,
        category: {name: "hello"}
      }
    }.to change(Category, :count).by(1)

    expect(response).to have_http_status(201)
  end
end
