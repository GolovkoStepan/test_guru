class FeedbacksController < ApplicationController
  def create
    if admin
      FeedbackMailer.send_user_feedback(admin.email, current_user, message).deliver
      redirect_to :root, notice: t('messages.feedback_sent')
    else
      redirect_to :root, notice: t('messages.feedback_sent_fail')
    end
  end

  private

  def admin
    @admin ||= User.where(role: :admin).first
  end

  def message
    @message ||= params[:feedback][:text]
  end
end
