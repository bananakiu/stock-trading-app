class WelcomeController < ApplicationController
  before_action :authorize_admin, only: %i[ all_transactions ]

  def index
  end

  def portfolio
    @portfolio = current_user.portfolios
  end

  def all_transactions
    @all_transactions = Transaction.all
  end

  private
  def authorize_admin
    return unless current_user.roles.find_by(name: "admin").nil?
    redirect_to "/", alert: 'Only admins are authorized to access that page.' # set to root path in the future
  end
end
