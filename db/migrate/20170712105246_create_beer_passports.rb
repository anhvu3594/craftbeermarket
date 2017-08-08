class CreateBeerPassports < ActiveRecord::Migration[5.1]
  def change
    create_table :beers_passports do |t|
      t.belongs_to :beer, index: true
      t.belongs_to :passport, index: true
    end
  end
end
