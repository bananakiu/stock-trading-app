### Test for trader user stories

require 'rails_helper'

RSpec.describe "Spec for user flows", type: :system do   
    fixtures :users

    before do
        driven_by(:rack_test)

        # login as approved user
        visit new_user_session_path
        fill_in 'user_email', :with => users(:two).email
        fill_in 'user_password', :with => "password"
        click_button 'Log in'
    end
    
    it "should view portfolio page" do     
        visit portfolio_path
        expect(page).to have_content "Portfolio"
    end

    it "should view transactions page" do     
        visit transactions_path
        expect(page).to have_content "Transactions"
    end
end