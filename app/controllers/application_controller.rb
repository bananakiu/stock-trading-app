class ApplicationController < ActionController::Base
    before_action :authenticate_user! # temporary. find out how to allow users to see landing page

    def needs_approval
        if current_user.approved == true
        else
            flash[:alert] = "Only approved users can transact. Please wait to be approved by an admin."
            redirect_to root_path
        end
    end
end
