class ContactMailer < ApplicationMailer
  default from: Rails.application.secrets.gmail_login

  def contact details
    puts "Calling ContactMailer"
    puts details.inspect
    mail(to: Rails.application.secrets.gmail_login, subject: "Testing this shit")
  end
end
