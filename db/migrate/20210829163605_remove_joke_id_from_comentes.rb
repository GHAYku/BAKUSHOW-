class RemoveJokeIdFromComentes < ActiveRecord::Migration[5.2]
  def change
   remove_column :Comentes, :joke_id, :integer
  end
end
