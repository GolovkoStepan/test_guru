# frozen_string_literal: true

class DispensingBadgeNotifyWorker
  include Sidekiq::Worker

  def perform(*args)
    logger.info 'DispensingBadgeNotifyWorker task started'

    issued_badge = IssuedBadge.find_by(id: args[0])
    return unless issued_badge

    logger.info 'IssuedBadge load'
    user    = issued_badge.user
    test    = issued_badge.statistic.test
    badge   = issued_badge.badge
    message = build_notification_text(user, test, badge)

    logger.info "Notification user of issue badge started [#{user.email}]"
    ActionCable.server.broadcast("badge_notifications_channel:#{user.id}", message: message)

    logger.info 'Notification user of issue badge finished'
    logger.info 'DispensingBadgeNotifyWorker task finished'
  end

  private

  def build_notification_text(user, test, badge)
    "#{user.username}, вы получили новую награду: '#{badge.name}' за прохождение теста '#{test.title}'!"
  end
end
