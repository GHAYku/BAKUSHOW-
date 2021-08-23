class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.integer :post_id
      t.integer :joke_id
      t.integer :end_user_id
      t.float :score

      t.timestamps
    end
  end
end
