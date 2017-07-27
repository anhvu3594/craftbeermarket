module API
  module V2
    module Guest
      class BeerController < Grape::API
        include API::V2::Defaults

        resource :guest_beer do
          desc 'Return a beer'
          params do
            requires :id, type: Integer, desc: "Beer id"
          end
          get ':id' do
            Beer.find(permitted_params[:id])
          end
        end
      end
    end
  end
end
