class ApplicationController < ActionController::Base
    before_action :authenticate_user! # temporary. find out how to allow users to see landing page
end
