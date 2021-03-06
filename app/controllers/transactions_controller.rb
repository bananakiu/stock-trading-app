class TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[ show edit update destroy ]
  before_action :get_api, except: %i[ create update destroy ]
  before_action :restrict_admin
  before_action :needs_approval

  # GET /transactions or /transactions.json
  def index
    @transactions = Transaction.where(user_id: current_user.id).order(created_at: :DESC)
    @toggle = "odd"
  end

  # GET /transactions/1 or /transactions/1.json
  def show
  end

  # GET /transactions/new
  def new
    @transaction = Transaction.new
    @ticker = params[:ticker]

    begin
      @stock_quote = @client.quote(@ticker)
      @company = @client.company(@ticker)
      @logo = @client.logo(@ticker)
    rescue IEX::Errors::SymbolNotFoundError => error
      flash[:alert] = error.message
      redirect_to stocks_search_path
    end

    @company_name = @company.company_name
    
  end

  # GET /transactions/1/edit
  def edit
  end

  # POST /transactions or /transactions.json
  def create
    @transaction = Transaction.new(transaction_params)

    # create portfolio entry if entry does not exist 
    current_user.portfolios.create(
      stock: transaction_params[:stock],
      shares: 0,
      total_cost: 0
    ) if current_user.portfolios.find_by(stock: transaction_params[:stock]).nil? # if stock is not yet in portfolio

    # update portfolio values based on transaction made
    portfolio_entry = current_user.portfolios.find_by(stock: transaction_params[:stock])
    if transaction_params[:action] == "Buy"
      # buy
      portfolio_entry.total_cost += transaction_params[:shares].to_d*transaction_params[:price_per_share].to_d
      portfolio_entry.shares += transaction_params[:shares].to_d
      portfolio_entry.save
    else
      # sell
      # check if you have enough to sell
      if transaction_params[:shares].to_d <= current_user.portfolios.find_by(stock: transaction_params[:stock]).shares
        # actually sell stock
        portfolio_entry.total_cost *= (1-(transaction_params[:shares].to_d / portfolio_entry.shares)) # TODO: re-check logic
        portfolio_entry.shares -= transaction_params[:shares].to_d
        portfolio_entry.save
      else
        # raise not enough shares error
        flash[:alert] = "You don't have enough shares to sell."
        redirect_to new_transaction_path(ticker: transaction_params[:stock])
        return
      end
    end

    respond_to do |format|
      if @transaction.save
        flash[:notice] = "Transaction was successfully updated."
        format.html { redirect_to transactions_path }
        format.json { render :show, status: :created, location: @transaction }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transactions/1 or /transactions/1.json
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        flash[:notice] = "Transaction was successfully created."
        format.html { redirect_to @transaction }
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1 or /transactions/1.json
  def destroy
    @transaction.destroy
    respond_to do |format|
      flash[:alert] = "Transaction was successfully destroyed."
      format.html { redirect_to transactions_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def transaction_params
      params.require(:transaction).permit(:user_id, :action, :stock, :shares, :price_per_share)
    end

    def get_api
      @client = IEX::Api::Client.new # credentials setup in config/intializers/iex_client.rb
    end

    def restrict_admin
      if user_signed_in?
        return if current_user.roles.find_by(name: "admin").nil?
        redirect_to "/", alert: 'Admins are not meant to trade.' # set to root path in the future
      else
        redirect_to "/", alert: 'You must be logged in to visit this page.'
      end
    end
end