class UserMailer < ApplicationMailer

  def cron_task_complete
    mail(to: ENV['gmail_login'], subject: 'Database is balanced.')
  end

end
