require 'rails_helper'

RSpec.describe "Transactions", type: :request do
  describe "Buying a stock" do
    fixtures :users
    fixtures :portfolios

    context "when trader is approved" do
      it "updates trader's portfolio" do
        trader = users(:one)
        sign_in trader

        # get purchase form
        get new_transaction_path
        expect(response).to have_http_status(200)
        initial_count = trader.portfolios.find_by(stock: "MSFT").shares

        # submit purchase form
        post transactions_path, :params => { 
          transaction: {
            stock: "MSFT",
            shares: 3,
            price_per_share: 100,
            user_id: trader.id,
            action: "Buy"
          }
        }
        expect(response).to have_http_status(302)
        follow_redirect!
        final_count = trader.portfolios.find_by(stock: "MSFT").shares

        # transaction show page
        expect(response.body).to include("3.0")
        expect(final_count - initial_count).to eq(3)
      end
    end

    context "when trader is not yet approved" do
      it "does not update trader's portfolio" do
      end
    end
  end

  describe "Selling a stock" do
  end
end
