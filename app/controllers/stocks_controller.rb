class StocksController < ApplicationController
  before_action :get_api, only: [:create, :search, :show]

  def search
    @toggle1 = "odd"
    @toggle2 = "odd"
    @toggle3 = "odd"
    begin
      @active = @client.stock_market_list(:mostactive).sort_by{|stock| stock.avg_total_volume}.reverse!
      @gainers = @client.stock_market_list(:gainers).sort_by{|stock| stock.change_percent}.reverse!
      @losers = @client.stock_market_list(:losers).sort_by{|stock| stock.change_percent}
    rescue IEX::Errors::SymbolNotFoundError => error
      flash[:alert] = error.message
      redirect_to root_path
    end
  end

  def create
    redirect_to stocks_show_path(stock_params)
  end
  
  def show 
    begin
      @quote = @client.quote(stock_params)
      @company = @client.company(stock_params)
      @logo = @client.logo(stock_params)
      @news = @client.news(stock_params, 9)
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
