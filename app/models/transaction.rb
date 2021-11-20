class Transaction < ApplicationRecord
  belongs_to :user

  validates :stock, presence: true
  validates :action, inclusion: { in: %w[Buy Sell] }
  validates :shares, presence: true, numericality: { greater_than: 0 }
  validates :price_per_share, presence: true

end
