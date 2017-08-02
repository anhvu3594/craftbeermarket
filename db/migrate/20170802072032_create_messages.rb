class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.belongs_to :room
      t.string :content
      t.belongs_to :user
      t.timestamps
    end
  end
end
