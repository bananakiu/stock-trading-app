class CreatePortfolios < ActiveRecord::Migration[6.1]
  def change
    create_table :portfolios do |t|
      t.references :user, null: false, foreign_key: true
      t.string :stock
      t.decimal :shares
      t.decimal :total_cost

      t.timestamps
    end
  end
end
