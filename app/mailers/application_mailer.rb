class ApplicationMailer < ActionMailer::Base
  puts "We are grabbing shit"
  default from: Rails.application.secrets.gmail_login
end
