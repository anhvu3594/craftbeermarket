module API
  module V1
    module Admin
      class CategoryController < Grape::API
        include API::V1::Defaults

        resource :admin_category do
          before do
            authenticate_admin!
          end

          desc 'Return all categories'
          params do
            requires :token, type: String, desc: 'Token'
          end
          get '' do
            Category.all
          end

          desc 'Create a category'
          params do
            requires :token, type: String, desc: 'Token'
            requires :category, type: Hash, desc: 'Category' do
              requires :name, type: String, desc: 'Name'
            end
          end
          post :create do
            Category.create!(name: params[:category][:name])
          end

          desc 'Delete a category'
          params do
            requires :token, type: String, desc: 'Token'
            requires :id, type: Integer, desc: 'Category Id'
          end
          delete ':id' do
            category = Category.find(params[:id])
            category.beers.first ? error!('This category still has beers', 404) : category.destroy!
          end
        end
      end
    end
  end
end
