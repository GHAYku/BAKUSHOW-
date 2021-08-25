class ChangeIsActiveDefaultOnEndUsers < ActiveRecord::Migration[5.2]
  def change
   change_column_default :end_users, :is_active, from: false, to: true
  end
end
