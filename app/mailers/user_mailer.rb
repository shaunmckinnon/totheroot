class UserMailer < ApplicationMailer

  def cron_task_complete
    recipients Rails.application.secrets.gmail_login
    from Rails.application.secrets.etsy_api_key
    subject 'Cron Task Complete'
    body 'All done bitches.'
  end

end
