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

          desc 'Consume a beer'
          params do
            requires :token, type: String, desc: 'Token'
            requires :beer_id, type: Integer, desc: 'Consumed beer id'
          end
          post :consume do
            beer = Beer.find(params[:beer_id])
            @current_user.passport.beers << beer
          end
        end
      end
    end
  end
end
