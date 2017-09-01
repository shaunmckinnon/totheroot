User.find_or_create_by(email: Rails.application.secrets.gmail_login) do |user|
  user.password = Rails.application.secrets.gmail_password
  user.password_confirmation = Rails.application.secrets.gmail_password
end