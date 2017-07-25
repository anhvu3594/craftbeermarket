module API
  module V1
    module Customer
      class BeerController < Grape::API
        include API::V1::Defaults

        resource :customer_beer do

          helpers do
            def passport
              @current_user.passport.beers
            end
          end

          before do
            authenticate!
          end

          desc 'Return all customer beers', entity: API::Entities::Beer, http_codes: [
            { code: 200, model: API::Entities::CustomerBeer },
            { code: 401, message: 'Unauthorized. Invalid or expired token.' }
          ]
          params do
            requires :token, type: String, desc: 'Token'
          end
          get '' do
            passport_beer_ids = passport.pluck(:id)
            available_beers = Beer.available.where.not(id: passport_beer_ids)
            {
              passport: collection_serializer.new(passport, each_serializer: BeerSerializer),
              available_beers: collection_serializer.new(available_beers, each_serializer: BeerSerializer)
            }
          end

          desc 'Consume a beer', entity: API::Entities::Beer, is_array: true, http_codes: [
            { code: 201, model: API::Entities::BeerResponse },
            { code: 401, message: 'Unauthorized. Invalid or expired token.' },
            { code: 404, message: "Couldn't find Beer with 'id'=" }
          ]
          params do
            requires :token, type: String, desc: 'Token'
            requires :beer_id, type: Integer, desc: 'Consumed beer id'
          end
          post :consume do
            beer = Beer.find(permitted_params[:beer_id])
            # check if beer is consumed before or not
            passport << beer unless passport.exists?(beer.id)
            passport
          end
        end
      end
    end
  end
end
