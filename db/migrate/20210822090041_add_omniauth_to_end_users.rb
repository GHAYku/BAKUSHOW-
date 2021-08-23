class AddOmniauthToEndUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :end_users, :provider, :string
    add_column :end_users, :uid, :string
  end
end
