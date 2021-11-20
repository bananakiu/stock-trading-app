require 'rails_helper'

RSpec.describe Portfolio, :type => :model do
  fixtures :users

  it "is valid with valid attributes" do
    portfolio = users(:two).portfolios.new(
      stock: "TEST",
      shares: 0,
      total_cost: 0
    )
    expect(portfolio).to be_valid
  end

  it "is not valid without a stock" do
    portfolio = users(:two).portfolios.new(
      stock: nil,
      shares: 0,
      total_cost: 0
    )
    expect(portfolio).to_not be_valid
  end

  it "is not valid with shares less than 0" do
    portfolio = users(:two).portfolios.new(
      stock: "TEST",
      shares: -1,
      total_cost: 0
    )
    expect(portfolio).to_not be_valid
  end

  it "is not valid with total_cost less than 0" do
    portfolio = users(:two).portfolios.new(
      stock: "TEST",
      shares: 0,
      total_cost: -1
    )
    expect(portfolio).to_not be_valid
  end
end