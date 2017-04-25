class ContactMailer < ApplicationMailer

  def contact message
    mail(to: Rails.application.secrets.gmail_login, subject: 'To the Root - Contact Form', message: message)
  end

end
