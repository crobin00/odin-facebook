class AddProfilePicUrlToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :profile_pic_url, :string
  end
end
