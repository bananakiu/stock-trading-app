# ### Test for trader user stories

# # cannot import config.include Devise::TestHelpers properly, causing the following error:
    # Failure/Error: @request.env['action_controller.instance'] = @controller
        
    # NoMethodError:
    # undefined method `env' for nil:NilClass

# require 'rails_helper'

# RSpec.describe "Spec for user flows", type: :system do   
#     fixtures :users
    
#     before do
#         driven_by(:rack_test)

#         # sign in as admin
#         visit new_user_session_path
#         fill_in 'user_email', :with => "admin@admin.com" # TODO: change to encrypted
#         fill_in 'user_password', :with => "password" # TODO: change to encrypted
#         click_button 'Log in'
#     end

#     it "should create new user account via admin panel" do   
#         visit new_admin_user_path
#         # fill_in 'user_first_name', :with => "Ab"
#         # fill_in 'user_last_name', :with => "Cd"
#         # fill_in 'user_email', :with => "abcd@example.com"    
#         # fill_in 'user_password', :with => "password"    
#         # fill_in 'user_password_confirmation', :with => "password"    
#         # click_button 'Create'
#         # expect(page).to have_content "User was successfully created."
#     end
# end