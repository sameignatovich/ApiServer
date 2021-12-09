Rails.application.config.action_mailer.smtp_settings = {
  address: 'email-smtp.us-east-2.amazonaws.com',
  port: 587,
  enable_starttls_auto: true,
  user_name: Rails.application.credentials.dig(:smtp, :username),
  password: Rails.application.credentials.dig(:smtp, :password),
}

Rails.application.config.action_mailer.delivery_method = :smtp

Rails.application.config.action_mailer.default_options = {
  from: 'info@big.wtf'
}
