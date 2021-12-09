class UserMailer < ApplicationMailer
  def test_mail
    mail(to: 'nikita@ignatovich.me', subject: 'Welcome to big.wtf')
  end
end
