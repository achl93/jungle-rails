class UserMailer < ApplicationMailer
  default from: "no-repy@jungle.com"

  def receipt_email(order)
    @user_email = order.email
    @order_id = order.id
    @line_items = order.line_items
    mail(to: @user_email, subject: 'Confirmation for order #: ' + @order_id.to_s)
  end
end
