class ApplicationMailer < ActionMailer::Base
  puts "We are grabbing shit"
  default from: ENV['gmail_login']
end
