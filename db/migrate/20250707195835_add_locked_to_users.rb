class AddLockedToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :locked, :boolean, default: true, null: false
  end
end
