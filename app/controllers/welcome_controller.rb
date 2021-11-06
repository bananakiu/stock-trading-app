class WelcomeController < ApplicationController
  def index
  end

  def all_transactions
    @all_transactions = Transaction.all
  end
end
