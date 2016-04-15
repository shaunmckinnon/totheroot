class UserMailer < ApplicationMailer

  def cron_task_complete
    mail(to: Rails.application.secrets.gmail_login, subject: 'Database is balanced.')
  end

end
