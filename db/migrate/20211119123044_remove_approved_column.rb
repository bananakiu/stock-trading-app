class RemoveApprovedColumn < ActiveRecord::Migration[6.1]
  def up
    remove_column :users, :confirmed, :boolean
  end
  def down
    add_column :users, :confirmed, :boolean
  end
end
