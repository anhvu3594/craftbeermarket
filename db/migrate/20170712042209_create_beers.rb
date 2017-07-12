class CreateBeers < ActiveRecord::Migration[5.1]
  def change
    create_table :beers do |t|
      t.belongs_to :category, index: true

      t.string :manufacturer, default: 'none'
      t.string :name, default: 'none'
      t.string :country, default: 'none'
      t.decimal :price, precision: 8, scale: 2
      t.string :description, default: 'none'
      t.boolean :is_archived, default: false

      t.timestamps
    end
  end
end
