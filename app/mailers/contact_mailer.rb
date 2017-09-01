class ContactMailer < ActionMailer::Base
  default from: Rails.application.secrets.gmail_login

  def contact params
    @params = params
    mail to: Rails.application.secrets.gmail_login, subject: "Just a test"
  end

end
