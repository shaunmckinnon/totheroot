# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :address                => "smtp.gmail.com",
  :port                   => 587,
  :user_name              => Rails.application.secrets.gmail_login,
  :password               => Rails.application.secrets.gmail_password,
  :authentication         => "plain",
  :enable_start_ttls_auto => true
}
