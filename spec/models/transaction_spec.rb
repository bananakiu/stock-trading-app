require 'rails_helper'

RSpec.describe Transaction, :type => :model do
  fixtures :users

  it "is valid with valid attributes" do
    transaction = users(:two).transactions.new(
      stock: "TEST",
      action: "Buy",
      shares: 1,
      price_per_share: 0
    )
    expect(transaction).to be_valid
  end
  it "is not valid without a stock" do
    transaction = users(:two).transactions.new(
      stock: nil,
      action: "Buy",
      shares: 1,
      price_per_share: 0
    )
    expect(transaction).to_not be_valid
  end
  it "is not valid without an action" do
    transaction = users(:two).transactions.new(
      stock: "TEST",
      action: "Buyz",
      shares: 1,
      price_per_share: 0
    )
    expect(transaction).to_not be_valid
  end
  it "is not valid with shares less than 0" do
    transaction = users(:two).transactions.new(
      stock: "TEST",
      action: "Buy",
      shares: -1,
      price_per_share: 0
    )
    expect(transaction).to_not be_valid
  end
  it "is not valid without price_per_share" do
    transaction = users(:two).transactions.new(
      stock: "TEST",
      action: "Buy",
      shares: 1,
      price_per_share: nil
    )
    expect(transaction).to_not be_valid
  end
end