module API
  module V1
    module Admin
      class BeerController < Grape::API
        include API::V1::Defaults

        helpers do
          def beer
            Beer.find(permitted_params[:id])
          end
        end

        resource :admin_beer do
          before do
            authenticate_admin!
          end

          desc 'Return all beers', entity: API::Entities::Beer, is_array: true, http_codes: [
            { code: 200, model: API::Entities::BeerResponse }
          ]
          params do
            requires :token, type: String, desc: 'Token'
          end
          get '' do
            Beer.all
          end

          # desc 'Create a beer'
          # , entity: API::Entities::Beer, http_codes: [
          #   { code: 201, model: API::Entities::BeerResponse },
          #   { code: 401, message: 'Unauthorized. Invalid or expired token.' },
          #   { code: 422, message: 'Validation failed' }
          # ]
          desc 'Create a beer'
          params do
            requires :token, type: String, desc: 'Token', documentation: {
              param_type: 'query'
            }
            requires :beer, type: Hash, desc: 'Beer' do
              requires :category_id, type: Integer, desc: 'Category Id'
              requires :manufacturer, type: String, desc: 'Manufacturer'
              requires :name, type: String, desc: 'Name'
              requires :country, type: String, desc: 'Country'
              requires :price, type: BigDecimal, desc: 'Price'
              requires :description, type: String, desc: 'Description'
            end
            # requires :beer, type: API::Entities::BeerRequest
          end
          post :create do
            Beer.create!(permitted_params[:beer])
          end

          desc 'Show a beer', entity: API::Entities::Beer, http_codes: [
            { code: 200, model: API::Entities::BeerResponse }
          ]
          params do
            requires :token, type: String, desc: 'Token'
            requires :id, type: Integer, desc: 'Beer Id'
          end
          get ':id' do
            beer
          end

          desc 'Edit a beer', entity: API::Entities::Beer, http_codes: [
            { code: 200, model: API::Entities::BeerResponse },
            { code: 401, message: 'Unauthorized. Invalid or expired token.' },
            { code: 422, message: 'Validation failed' },
            { code: 404, message: "Couldn't find Beer with 'id'=" }
          ]
          params do
            requires :token, type: String, desc: 'Token', documentation: {
              param_type: 'query'
            }
            requires :id, type: Integer, desc: 'Beer Id'
            requires :beer, type: Hash, desc: 'Beer' do
              requires :category_id, type: Integer, desc: 'Category Id'
              requires :manufacturer, type: String, desc: 'Manufacturer'
              requires :name, type: String, desc: 'Name'
              requires :country, type: String, desc: 'Country'
              requires :price, type: BigDecimal, desc: 'Price'
              requires :description, type: String, desc: 'Description'
            end
          end
          put 'edit/:id' do
            beer if beer.update!(permitted_params[:beer])
          end

          desc 'Archive a beer', http_codes: [
            { code: 200, message: "Sucess" },
            { code: 401, message: 'Unauthorized. Invalid or expired token.' },
            { code: 422, message: 'Validation failed' },
            { code: 404, message: "Couldn't find Beer with 'id'=" }
          ]
          params do
            requires :token, type: String, desc: 'Token', documentation: {
              param_type: 'query'
            }
            requires :id, type: Integer, desc: 'Beer Id'
          end
          put 'archive/:id' do
            beer.update!(is_archived: true)
          end

          desc 'Unarchive a beer', http_codes: [
            { code: 200, message: "Success" },
            { code: 401, message: 'Unauthorized. Invalid or expired token.' },
            { code: 422, message: 'Validation failed' },
            { code: 404, message: "Couldn't find Beer with 'id'=" }
          ]
          params do
            requires :token, type: String, desc: 'Token', documentation: {
              param_type: 'query'
            }
            requires :id, type: Integer, desc: 'Beer Id'
          end
          put 'unarchive/:id' do
            beer.update!(is_archived: false)
          end

          # desc 'Delete a beer'
          # permitted_params do
          #   requires :token, type: String, desc: 'Token'
          #   requires :id, type: Integer, desc: 'Beer Id'
          # end
          # delete 'delete/:id' do
          #   beer.destroy!
          # end
        end
      end
    end
  end
end
