module API
  module V2
    class Base < Grape::API
      # guest
      mount API::V2::Guest::BeerController
    end
  end
end
