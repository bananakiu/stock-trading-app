class UserMailer < ApplicationMailer
    default from: 'notifications@example.com'
    
    def approval_email
        @user = params[:user]
        @url  = 'http://example.com/users/sign_in'
        mail(to: @user.email, subject: "You've been approved!")
    end
end