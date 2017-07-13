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

          desc 'Return all customer beers'
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

          desc 'Consume a beer'
          params do
            requires :token, type: String, desc: 'Token'
            requires :beer_id, type: Integer, desc: 'Consumed beer id'
          end
          post :consume do
            beer = Beer.find(params[:beer_id])
            # check if beer is consumed before or not
            passport << beer unless passport.exists?(beer.id)
            passport
          end
        end
      end
    end
  end
end
