class CreateComentes < ActiveRecord::Migration[5.2]
  def change
    create_table :comentes do |t|
      t.integer :post_id
      t.integer :joke_id
      t.integer :end_user_id
      t.text :body

      t.timestamps
    end
  end
end
