class WelcomeController < ApplicationController
  before_action :authorize_admin, only: %i[ all_transactions approvals ]
  before_action :restrict_admin, only: %i[ portfolio ]
  before_action :get_api, only: %i[ portfolio all_transactions index ]

  def index
    # if not admin, call API
    if current_user&.roles&.find_by(name: "admin").nil?
      begin
        @active5 = @client.stock_market_list(:mostactive)[0..4]
      rescue IEX::Errors::SymbolNotFoundError => error
        flash[:alert] = error.message
        redirect_to edit_user_registration_path
      end
    end
  end

  def portfolio
    @portfolio = current_user.portfolios
    @toggle = "odd"
  end

  def all_transactions
    @all_transactions = Transaction.all
    @toggle = "odd"
  end

  def approvals
    @unapproved_users = User.where(approved: false)
    @toggle = "odd"
  end

  private
    def authorize_admin
      if user_signed_in?
        return unless current_user.roles.find_by(name: "admin").nil?
        flash[:alert] = 'Only admins are authorized to access that page.' 
        redirect_to "/" # set to root path in the future
      else
        redirect_to "/", alert: 'You must be logged in to visit this page.'
      end
    end

    def restrict_admin
      if user_signed_in?
        return if current_user.roles.find_by(name: "admin").nil?
        redirect_to "/", alert: 'Admins are not meant to trade.' # set to root path in the future
      else
        redirect_to "/", alert: 'You must be logged in to visit this page.'
      end
    end

    def get_api
      @client = IEX::Api::Client.new # credentials setup in config/intializers/iex_client.rb
    end
end
