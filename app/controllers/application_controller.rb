class ApplicationController < ActionController::Base
    before_action :authenticate_user! # temporary. find out how to allow users to see landing page

    def needs_confirmation
        flash[:alert] = "Only confirmed users can transact. Please confirm your email."
        redirect_to root_path unless current_user.confirmed?
    end
end
