# frozen_string_literal: true

class FeedbacksController < ApplicationController
  skip_before_action :authenticate_user!

  def create
    FeedbackMailer.send_user_feedback(admin&.email, current_user, message).deliver
    redirect_to :root, notice: t('messages.feedback_sent')
  end

  private

  def admin
    @admin ||= User.where(role: :admin)&.first
  end

  def message
    @message ||= params[:feedback][:text]
  end
end
