Rails.application.config.action_mailer.smtp_settings = {
  address: 'email-smtp.us-east-2.amazonaws.com',
  port: 465,
  tls: true,
  user_name: Rails.application.credentials.dig(:smtp, :username),
  password: Rails.application.credentials.dig(:smtp, :password)
}

Rails.application.config.action_mailer.delivery_method = :smtp

Rails.application.config.action_mailer.default_options = {
  from: 'info@soligorsk.place'
}
