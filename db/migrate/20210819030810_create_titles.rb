class CreateTitles < ActiveRecord::Migration[5.2]
  def change
    create_table :titles do |t|
      t.integer :genre_id
      t.integer :end_user_id
      t.string :image_id
      t.text :body

      t.timestamps
    end
  end
end
