module API
  module V1
    module Guest
      class BeerController < Grape::API
        include API::V1::Defaults

        resource :guest_beer do
          # desc 'Return all available beers', entity: API::Entities::Beer, is_array: true, http_codes: [
          #   { code: 200, model: API::Entities::BeerResponse }
          # ]
          desc 'Return all available beers'
          get '' do
            Beer.available
          end
        end
      end
    end
  end
end
