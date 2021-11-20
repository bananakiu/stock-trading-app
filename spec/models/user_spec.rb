require 'rails_helper'

RSpec.describe User, :type => :model do
  it "is valid with valid attributes" do
    user = User.new(
      first_name: "John",
      last_name: "Doe",
      email: "johndoe@apple.com",
      password: "password"
    )
    expect(user).to be_valid
  end
  it "is not valid without a first_name" do
    user = User.new(first_name: nil)
    expect(user).to_not be_valid
  end
  it "is not valid without a last_name" do
    user = User.new(last_name: nil)
    expect(user).to_not be_valid
  end
  it "is not valid with a balance less than 0" do
    user = User.new(balance: -1)
    expect(user).to_not be_valid
  end
end