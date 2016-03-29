# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :address                => 'smtp.gmail.com',
  :port                   => 587,
  :domain                 => 'gmail.com',
  :user_name              => Rails.application.secrets.gmail_login,
  :password               => Rails.application.secrets.gmail_password,
  :authentication         => :login,
  :enable_start_ttls_auto => true
}
