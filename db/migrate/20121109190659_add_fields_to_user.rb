class AddFieldsToUser < ActiveRecord::Migration
  def up
  	add_column :users, :name, :string
  	add_column :users, :birthday, :string
  	add_column :users, :title, :string
  	add_column :users, :profile_pic, :string
  	add_column :users, :likes, :text
  	add_column :users, :groups, :text
  	add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_column :users, :oauth_token, :string
    add_column :users, :oauth_expires_at, :string
  end
end
