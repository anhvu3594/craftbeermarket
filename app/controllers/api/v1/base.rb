require 'grape-swagger-rails'

module API
  module V1
    class Base < Grape::API
      # admin
      mount API::V1::AuthenticationController
      mount API::V1::Admin::AccountController
      mount API::V1::Admin::CategoryController
      mount API::V1::Admin::BeerController

      # customer
      mount API::V1::Customer::BeerController

      # guest
      mount API::V1::Guest::BeerController

      #chat
      mount API::V1::Chat::ChatroomController
      
    end
  end
end
