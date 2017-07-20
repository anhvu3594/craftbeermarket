class Category < ApplicationRecord

  has_many :beers

  validates :name, presence: true

end
