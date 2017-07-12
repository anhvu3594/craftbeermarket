module API
  module V1
    module Admin
      class CategoryController < Grape::API
        include API::V1::Defaults

        resource :category do
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
            category = Category.create!(name: params[:category][:name])
            if category
              { status: 200, data: category}
            else
              category.error
            end
          end
        end
      end
    end
  end
end
