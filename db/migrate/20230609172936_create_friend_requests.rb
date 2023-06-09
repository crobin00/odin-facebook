class CreateFriendRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :friend_requests do |t|
      t.references :sent_user, null: false
      t.references :received_user, null: false

      t.timestamps
    end
    add_foreign_key :friend_requests, :users, column: :sent_user_id
    add_foreign_key :friend_requests, :users, column: :received_user_id
  end
end
