require "grape-swagger-rails"

module API
  module V1
    class Base < Grape::API
      mount API::V1::Test
      mount API::V1::Authentication
      mount API::V1::Admin::UserAccount
    end
  end
end
