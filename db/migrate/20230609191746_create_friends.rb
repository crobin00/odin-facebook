class CreateFriends < ActiveRecord::Migration[7.0]
  def change
    create_table :friends do |t|
      t.references :user, null: false, foreign_key: true
      t.references :friend, null: false

      t.timestamps
    end
    add_foreign_key :friends, :users, column: :friend_id
  end
end
