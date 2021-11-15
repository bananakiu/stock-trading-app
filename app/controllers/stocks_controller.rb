class StocksController < ApplicationController
  before_action :get_api, only: [:create, :search, :show]

  def search
    @active = @client.stock_market_list(:mostactive)
    @gainers = @client.stock_market_list(:gainers)
    @losers = @client.stock_market_list(:losers)
  end

  def create
    redirect_to stocks_show_path(stock_params)
  end
  
  def show 
    begin
      @quote = @client.quote(stock_params)
      @company = @client.company(stock_params)
    rescue IEX::Errors::SymbolNotFoundError => error
      flash[:alert] = error.message
      redirect_to stocks_search_path
    end
  end

  private

  def stock_params
    params[:ticker]
  end

  def get_api
    @client = IEX::Api::Client.new # credentials setup in config/intializers/iex_client.rb
  end

end