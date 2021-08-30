class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.integer :post_id
      t.integer :end_user_id
      t.float :rate, null: false
      t.text :comment
      t.timestamps
    end
  end
end
