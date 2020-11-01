# frozen_string_literal: true

class DispensingBadgesWorker
  include Sidekiq::Worker

  def perform(*args)
    logger.info 'DispensingBadgesWorker task started'

    statistic = Statistic.find_by(id: args[0])
    return unless statistic

    logger.info 'Statistic load'
    logger.info "Dispensing badges for the user [#{statistic.user.email}] started"
    BadgesService.new(statistic).issue_badges_to_user do |issue_badge|
      DispensingBadgeNotifyWorker.perform_in(10.seconds, issue_badge.id)
    end

    logger.info 'Dispensing badges for the user finished'
    logger.info 'DispensingBadgesWorker task finished'
  end
end
