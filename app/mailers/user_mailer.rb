class UserMailer < ApplicationMailer
  default from: "no-repy@jungle.com"

  def receipt_email(user_email, order_id)
    @user_email = user_email
    @order_id = order_id
    mail(to: @user_email, subject: 'Confirmation for order #: ' + @order_id.to_s)
  end
end
