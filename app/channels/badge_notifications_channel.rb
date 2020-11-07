# frozen_string_literal: true

class BadgeNotificationsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "badge_notifications_channel:#{current_user.id}"
  end
end
