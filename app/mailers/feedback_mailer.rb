class FeedbackMailer < ApplicationMailer
  def send_user_feedback(email, user, msg)
    message = "Пользователь #{user.email} отправил сообщение: #{msg}"
    mail(to: email, subject: 'Сообщение пользователя', body: message)
  end
end
