class CreateTokens < ActiveRecord::Migration[5.1]
  def change
    create_table :tokens do |t|
      t.string :access_token, null: false
      t.datetime :expires_at, null: false

      t.timestamps

      t.belongs_to :user, index: true
    end
  end
end
