class CreateFriends < ActiveRecord::Migration[5.1]
  def change
    create_table :friends do |t|
      t.belongs_to :user, index: true
      t.references :friend, index: true, foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
