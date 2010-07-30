ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.perform_deliveries = true

class MailMan < ActionMailer::Base
  default_url_options[:host] = "localhost:3000"
  def password_reset_instructions(user)
    subject 'Password Reset Instructions'
    from "Rails Forum 2.3.2"
    recipients user.email
    sent_on Time.now
    body :edit_password_reset_url \
      => edit_password_reset_url(user.perishable_token)
  end

end
