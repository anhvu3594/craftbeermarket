module API
  module Entities
    class Category < Grape::Entity
      expose :id, documentation: { type: 'Integer', desc: 'Category id' }
      expose :name, documentation: { type: 'String', desc: 'Category name' }
    end

    class CategoryRequest < Category
      unexpose :id
    end
  end
end
