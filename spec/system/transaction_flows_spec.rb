### Test for user CRUD

require 'rails_helper'

RSpec.describe "Spec for Sign Up", type: :system do   
    fixtures :users
    
    before do
        driven_by(:rack_test)

        # Log in before tests below
        visit new_user_session_path
        fill_in 'user_email', :with => users(:two).email
        fill_in 'user_password', :with => "password"
        click_button 'Log in'
    end

    it "should allow user to buy a stock" do     
      visit new_transaction_path(ticker: 'MSFT')
      select "Buy", :from => "transaction_action"
      fill_in 'transaction_shares', :with => 17
      click_button 'Trade'
      expect(page).to have_content "Transaction was successfully updated."
      # visit stocks_search_path	
      # fill_in 'ticker', :with => "MSFT"
      # find('#search').click
      # expect(page).to have_content "MSFT"
      # click_button 'Trade'
      # find("#transaction_action option[value='buy']")
      # fill_in 'shares', :with => 17
      # click_button 'Trade'
      # expect(page).to have_content "Transaction was successfully updated."
    end

    it "should allow user to sell a stock" do
      # Buying
      visit new_transaction_path(ticker: 'MSFT')
      select "Buy", :from => "transaction_action"
      fill_in 'transaction_shares', :with => 100
      click_button 'Trade'
      # Selling 
      visit new_transaction_path(ticker: 'MSFT')
      select "Sell", :from => "transaction_action"
      fill_in 'transaction_shares', :with => 17
      click_button 'Trade'
      expect(page).to have_content "Transaction was successfully updated."
    end
end