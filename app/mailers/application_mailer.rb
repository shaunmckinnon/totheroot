class ApplicationMailer < ActionMailer::Base

  default from: Rails.application.secrets.gmail_login
  layout 'mailer'
  
end
