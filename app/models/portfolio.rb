class Portfolio < ApplicationRecord
  belongs_to :user

  def average_price
    self.total_cost / self.shares
  end

  def market_price_total(market_price_per_share)
    self.shares * market_price_per_share
  end

  def pnl(market_price_per_share)
    self.market_price_total(market_price_per_share) - self.total_cost
  end

  def pnl_perc(market_price_per_share)
    self.pnl(market_price_per_share)/self.total_cost
  end
end
