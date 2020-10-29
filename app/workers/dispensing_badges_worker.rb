# frozen_string_literal: true

class DispensingBadgesWorker
  include Sidekiq::Worker

  def perform(*args)
    logger.info 'DispensingBadgesWorker task started'

    statistic = Statistic.find(args[0])
    return unless statistic

    logger.info 'Statistic load'
    logger.info "Dispensing badges for the user [#{statistic.user.email}] started"
    BadgesService.new(statistic).give_the_user

    logger.info 'Dispensing badges for the user finished'
    logger.info 'DispensingBadgesWorker task finished'
  end
end
