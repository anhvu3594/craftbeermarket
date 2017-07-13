class Beer < ApplicationRecord

  scope :available, -> { where(is_archived: false) }
  scope :archived, -> { where(is_archived: true) }

  belongs_to :category
  has_and_belongs_to_many :passports
end
