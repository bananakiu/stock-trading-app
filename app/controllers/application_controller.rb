class ApplicationController < ActionController::Base
    before_action :authenticate_user! # temporary. find out how to allow users to see landing page

    def needs_confirmation
        if current_user.confirmed?
        else
            flash[:alert] = "Only confirmed users can transact. Please confirm your email."
            redirect_to root_path
        end
    end
end
