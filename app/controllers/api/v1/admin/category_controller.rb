module API
  module V1
    module Admin
      class CategoryController < Grape::API
        include API::V1::Defaults

        resource :admin_category do
          before do
            authenticate_admin!
          end

          desc 'Return all categories', entity: API::Entities::Category, is_array: true, http_codes: [
            { code: 200, model: API::Entities::Category }
          ]
          params do
            requires :token, type: String, desc: 'Token'
          end
          get '' do
            Category.all
          end

          desc 'Create a category', http_codes: [
            { code: 201, model: API::Entities::Category },
            { code: 401, message: 'Unauthorized. Invalid or expired token.' },
            { code: 422, message: 'Validation failed' }
          ]
          params do
            requires :category, type: API::Entities::CategoryRequest
            requires :token, type: String, desc: 'Token', documentation: {
              param_type: 'query'
            }
          end
          post :create do
            Category.create!(permitted_params[:category])
          end

          desc 'Delete a category', http_codes: [
            { code: 204, message: 'Delete successfully' },
            { code: 400, message: 'This category still has beers' },
            { code: 401, message: 'Unauthorized. Invalid or expired token.' },
            { code: 404, message: "Couldn't find Category with 'id'=" }
          ]
          params do
            requires :token, type: String, desc: 'Token'
            requires :id, type: Integer, desc: 'Category Id'
          end
          delete ':id' do
            category = Category.find(permitted_params[:id])
            category.beers.first ? error!('This category still has beers', 400) : category.destroy!
          end
        end
      end
    end
  end
end
