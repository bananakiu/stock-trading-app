class WelcomeController < ApplicationController
  before_action :authorize_admin, only: %i[ all_transactions ]
  before_action :restrict_admin, only: %i[ portfolio ]

  def index
  end

  def portfolio
    @portfolio = current_user.portfolios
  end

  def all_transactions
    @all_transactions = Transaction.all
  end

  def approvals
    @unapproved_users = User.where(approved: false)
  end

  private
  def authorize_admin
    return unless current_user.roles.find_by(name: "admin").nil?
    flash[:alert] = 'Only admins are authorized to access that page.' 
    redirect_to "/" # set to root path in the future
  end

  def restrict_admin
    return if current_user.roles.find_by(name: "admin").nil?
    redirect_to "/", alert: 'Admins are not meant to trade.' # set to root path in the future
  end
end
