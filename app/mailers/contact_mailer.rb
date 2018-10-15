class ContactMailer < ActionMailer::Base
  default from: ENV['gmail_login']

  def contact params
    @params = params
    mail to: "#{ENV['gmail_login']}, janel@totheroot.ca", subject: "Contact Page Inquiry"
  end

end
