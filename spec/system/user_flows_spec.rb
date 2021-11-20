### Test for trader user stories

require 'rails_helper'

RSpec.describe "Spec for user flows", type: :system do   
    fixtures :users
    
    before do
        driven_by(:rack_test)
    end

    it "should create new user account" do   
        visit new_user_registration_path
        fill_in 'user_first_name', :with => "Ab"
        fill_in 'user_last_name', :with => "Cd"
        fill_in 'user_email', :with => "abcd@example.com"    
        fill_in 'user_password', :with => "password"    
        fill_in 'user_password_confirmation', :with => "password"    
        click_button 'Sign up'    
        expect(page).to have_content "Welcome! You have signed up successfully."
    end

    # https://newbedev.com/how-to-create-fixtures-for-a-devise-user-as-a-yml-erb-in-rails-4-1-5
    it "should log in with existing user account" do     
        visit new_user_session_path
        fill_in 'user_email', :with => users(:one).email
        fill_in 'user_password', :with => "password"
        click_button 'Log in'
        expect(page).to have_content "Signed in successfully."
    end

    # https://stackoverflow.com/questions/7284413/how-to-test-with-rspec-if-an-email-is-delivered
    # https://relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    it "should deliver email once signed up" do 
        # sign up
        # TODO: improve, because not DRY
        visit new_user_registration_path
        fill_in 'user_first_name', :with => "Ab"
        fill_in 'user_last_name', :with => "Cd"
        fill_in 'user_email', :with => "abcd@example.com"    
        fill_in 'user_password', :with => "password"    
        fill_in 'user_password_confirmation', :with => "password"    
        click_button 'Sign up'

        # check if there was a delivered email
        email = ActionMailer::Base.deliveries.last
        expect(email.nil?).to be(false)
    end
end