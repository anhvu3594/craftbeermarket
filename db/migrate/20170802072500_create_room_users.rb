class CreateRoomUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :chatrooms_users do |t|
      t.belongs_to :chatroom, index: true
      t.belongs_to :user, index: true
    end
  end
end
