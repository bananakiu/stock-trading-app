class Transaction < ApplicationRecord
  belongs_to :user

  validates :stock, presence: true
  validates :action, presence: true
  # validates :shares, presence: true, numericality: { greater_than: 0 }

end
