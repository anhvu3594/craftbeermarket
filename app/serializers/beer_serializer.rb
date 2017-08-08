class BeerSerializer < ActiveModel::Serializer
  attributes :id, :name, :manufacturer, :country, :price, :description, :category, :is_archived

  def category
    CategorySerializer.new(object.category)
  end
end
