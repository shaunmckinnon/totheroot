User.find_or_create_by(email: Rails.application.secrets.gmail_login) do |user|
  user.encrypted_password = Rails.application.secrets.gmail_password
end