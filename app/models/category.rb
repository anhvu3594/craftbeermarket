class Category < ApplicationRecord

  has_many :beers

  validates :name, presence: true, length: { maximum: 50 }

end
