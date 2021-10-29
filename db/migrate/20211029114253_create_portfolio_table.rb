class CreatePortfolioTable < ActiveRecord::Migration[6.1]
  def change
    create_table :portfolio_tables do |t|
      t.references :user, null: false, foreign_key: true
      t.references :stock, null: false, foreign_key: true
      t.decimal :shares
      t.decimal :total_cost
      t.timestamps
    end
  end
end
