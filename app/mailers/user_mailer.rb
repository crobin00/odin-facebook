class UserMailer < ApplicationMailer
  def welcome_email
    @user = params[:user]
    @url = 'localhost:3000/users/sign_in'
    mail(to: @user.email, subject: "Thank you for signing up to Odinbook!")
  end
end
