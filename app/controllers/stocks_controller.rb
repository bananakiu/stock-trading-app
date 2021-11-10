class StocksController < ApplicationController
  before_action :get_api, only: [:create, :search, :show]

  def search
  end

  def create
    # @quote = @client.quote(stock_params[:ticker])
    redirect_to stocks_show_path(stock_params)
    
    # begin
    #   @quote = @client.quote(stock_params)
    #   @stock = @client.company(stock_params).company_name
    # rescue IEX::Errors::SymbolNotFoundError => error
    #   flash[:alert] = error.message
    #   redirect_to stocks_search_path
    # end
  end
  
  def show 
    @quote = @client.quote(stock_params)
    @company = @client.company(stock_params)
  end

  private

  def stock_params
    params[:ticker]
  end

  def get_api
    @client = IEX::Api::Client.new # credentials setup in config/intializers/iex_client.rb
  end

end
