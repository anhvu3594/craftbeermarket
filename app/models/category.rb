class Category < ApplicationRecord
  has_many :beers

  validates :name, presence: true

  before_destroy { throw :abort if had_beer? }

  def had_beer?
    beers.first ? true : false
  end
end
