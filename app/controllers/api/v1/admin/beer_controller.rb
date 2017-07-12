module API
  module V1
    module Admin
      class BeerController < Grape::API
        include API::V1::Defaults

        helpers do
          def beer
            Beer.find(params[:id])
          end
        end

        resource :beer do
          before do
            authenticate_admin!
          end

          desc 'Return all beers'
          params do
            requires :token, type: String, desc: 'Token'
          end
          get '' do
            Beer.all
          end

          desc 'Create a beer'
          params do
            requires :token, type: String, desc: 'Token'
            requires :beer, type: Hash, desc: 'Beer' do
              requires :category_id, type: Integer, desc: 'Category Id'
              requires :manufacturer, type: String, desc: 'Manufacturer'
              requires :name, type: String, desc: 'Name'
              requires :country, type: String, desc: 'Country'
              requires :price, type: BigDecimal, desc: 'Price'
              requires :description, type: String, desc: 'Description'
            end
          end
          post :create do
            Beer.create!(params[:beer])
          end

          desc 'Show a beer'
          params do
            requires :token, type: String, desc: 'Token'
            requires :id, type: Integer, desc: 'Beer Id'
          end
          get ':id' do
            beer
          end

          desc 'Edit a beer'
          params do
            requires :token, type: String, desc: 'Token'
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
            beer if beer.update!(params[:beer])
          end

          desc 'Archive a beer'
          params do
            requires :token, type: String, desc: 'Token'
            requires :id, type: Integer, desc: 'Beer Id'
          end
          put 'archive/:id' do
            beer.update!(is_archived: true)
          end

          desc 'Unarchive a beer'
          params do
            requires :token, type: String, desc: 'Token'
            requires :id, type: Integer, desc: 'Beer Id'
          end
          put 'unarchive/:id' do
            beer.update!(is_archived: false)
          end

          desc 'Delete a beer'
          params do
            requires :token, type: String, desc: 'Token'
            requires :id, type: Integer, desc: 'Beer Id'
          end
          delete 'delete/:id' do
            beer.destroy!
          end
        end
      end
    end
  end
end
