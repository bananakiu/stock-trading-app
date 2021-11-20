class AddDefaultBalance < ActiveRecord::Migration[6.1]
  def up
    change_column :users, :balance, :decimal, :default => 1000000
  end
  def down
    change_column :users, :balance, :decimal
  end
end
