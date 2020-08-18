class FeedbackMailer < ApplicationMailer
  DEFAULT_ADMIN_EMAIL = 'stepangolovkodev@gmail.com'.freeze

  def send_user_feedback(email, user, msg)
    message = "Пользователь #{user_email(user)} отправил сообщение: #{msg}"
    mail(to: admin_email(email), subject: 'Сообщение пользователя', body: message)
  end

  private

  def user_email(user)
    user&.email || 'noname'
  end

  def admin_email(email)
    email || DEFAULT_ADMIN_EMAIL
  end
end
