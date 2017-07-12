require "grape-swagger-rails"

module API
  module V1
    class Base < Grape::API
      # mount API::V1::Test
      mount API::V1::AuthenticationController
      mount API::V1::Admin::AccountController
      mount API::V1::Admin::CategoryController
      mount API::V1::Admin::BeerController
    end
  end
end
