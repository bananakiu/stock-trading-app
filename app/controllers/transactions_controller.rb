class TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[ show edit update destroy ]
  before_action :get_api, except: %i[ create update destroy ]

  # GET /transactions or /transactions.json
  def index
    @transactions = Transaction.where(user_id: current_user.id)
  end

  # GET /transactions/1 or /transactions/1.json
  def show
  end

  # GET /transactions/new
  def new
    @transaction = Transaction.new
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
      portfolio_entry.total_cost *= (1-(transaction_params[:shares].to_d / portfolio_entry.shares)) # TODO: re-check logic
      portfolio_entry.shares -= transaction_params[:shares].to_d
      portfolio_entry.save
    end
    # TODO: OPERATIONS AREN'T WORKING!

    respond_to do |format|
      if @transaction.save
        flash[:notice] = "Transaction was successfully updated."
        format.html { redirect_to @transaction }
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
end