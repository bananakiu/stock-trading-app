class FixColumnNames < ActiveRecord::Migration[6.1]
  def change
    rename_column :transactions, :amount, :shares
    rename_column :transactions, :total_price, :price_per_share
  end
end
