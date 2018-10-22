class UserMailer < ApplicationMailer
  def account_activation(user)
    @user = user

    mail to: user.email, subject: 'Account Activation'
  end

  def password_reset(user)
    @user = user

    mail to: user.email, subject: 'Password Reset'
  end

  def email_notification(user, message)
    @user = user
    @message = message

    mail to: user.email, subject: 'Recipe notification'
  end
end
