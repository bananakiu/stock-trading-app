### Test for user CRUD

require 'rails_helper'

RSpec.describe "Spec for Sign Up", type: :system do   
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
end