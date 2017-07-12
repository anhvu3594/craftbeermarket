module API
  module V1
    module Customer
      class BeerController < Grape::API
        include API::V1::Defaults
        resource :customer_beer do
          before do
            authenticate!
          end

          desc 'Return all beers'
          params do
            requires :token, type: String, desc: 'Token'
          end
          get '' do
            Beer.all
          end
        end
      end
    end
  end
end
