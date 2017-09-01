class PagesController < ApplicationController

  def contact
  end

  def contact_form_process
    puts "We ARE contacting!!!"
    ContactMailer.contact(params).deliver_now

    puts "We are redirecting"
    redirect_to contact_us_path, notice: 'Your message was sent. Thank you for contacting To The Root.'
  end

  def about
  end

  def faq
  end

end
