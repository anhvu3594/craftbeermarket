class Category < ApplicationRecord

  has_many :beers

  validates :name, presence: true

  before_destroy { throw :abort if self.hadBeer?}

  def hadBeer?
    self.beers.first ? true : false
  end
end
