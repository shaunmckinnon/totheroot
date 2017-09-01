class PagesController < ApplicationController

  def contact
  end

  def contact_form_process
    ContactMailer.contact params

    redirect_to contact_us_path, notice: 'Your message was sent. Thank you for contacting To The Root.'
  end

  def about
  end

end
