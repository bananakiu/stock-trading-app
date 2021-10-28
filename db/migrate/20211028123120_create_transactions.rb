class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :stock, null: false, foreign_key: true
      t.string :action
      t.decimal :amount
      t.decimal :total_price

      t.timestamps
    end
  end
end
