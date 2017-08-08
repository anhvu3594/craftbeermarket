module API
  module Entities
    class Beer < Grape::Entity
      expose :id, documentation: { type: 'Integer', desc: 'Beer id' }
      expose :category_id, documentation: { type: 'Integer', desc: 'Category id' }
      expose :manufacturer, documentation: { type: 'String', desc: 'Beer manufacturer' }
      expose :name, documentation: { type: 'String', desc: 'Beer name' }
      expose :country, documentation: { type: 'String', desc: 'Beer country' }
      expose :price, documentation: { type: 'BigDecimal', desc: 'Price' }
      expose :description, documentation: { type: 'String', desc: 'Description' }
      expose :is_archived, documentation: { type: 'Boolean', desc: 'Beer is archived or not' }
    end

    class BeerRequest < Beer
      unexpose :id
      unexpose :is_archived
    end

    class BeerResponse < Beer
      unexpose :category_id
      expose :category, using: API::Entities::Category
    end

    class CustomerBeer < Grape::Entity
      expose :passport, using: API::Entities::Beer, documentation: { is_array: true }
      expose :available_beers, using: API::Entities::Beer, documentation: { is_array: true }
    end
  end
end
