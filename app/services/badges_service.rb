# frozen_string_literal: true

class BadgesService
  RULES = %w[one_try all_by_level all_by_category].freeze

  def initialize(statistic)
    @statistic = statistic
    @user      = statistic.user
    @test      = statistic.test
  end

  def badges_for_give_out
    Badge.all.map do |badge|
      rule_method    = "#{badge.rule}?".to_sym
      @current_badge = badge
      send(rule_method, badge.rule_value) ? badge : nil
    end.compact
  end

  def issue_badges_to_user
    return unless @statistic.success_complete

    badges_for_give_out.each do |badge|
      issue_badge = IssuedBadge.create!(badge: badge, user: @user, statistic: @statistic)
      yield(issue_badge) if block_given?
    end
  end

  private

  def one_try?(_)
    Statistic.where(user: @user, test: @test).count == 1
  end

  def all_by_level?(level)
    return unless @test.level == level.to_i

    last_issue_date = IssuedBadge.order(:created_at).where(user: @user, badge: @current_badge).last&.created_at
    test_ids        = Test.where(level: level.to_i).order(:id).pluck(:id)
    statistics      = Statistic.joins(:test).where(user: @user, success_complete: true, tests: { level: level.to_i })
    statistics      = statistics.where('statistics.created_at > :date', date: last_issue_date) if last_issue_date

    test_ids == statistics.order(:test_id).distinct.pluck(:test_id)
  end

  def all_by_category?(category_name)
    return unless @test.category.title == category_name

    category        = Category.find_by(title: category_name)
    last_issue_date = IssuedBadge.order(:created_at).where(user: @user, badge: @current_badge).last&.created_at
    test_ids        = Test.where(category: category).order(:id).pluck(:id)
    statistics      = Statistic.joins(:test).where(user: @user, success_complete: true, tests: { category: category })
    statistics      = statistics.where('statistics.created_at > :date', date: last_issue_date) if last_issue_date

    test_ids == statistics.order(:test_id).distinct.pluck(:test_id)
  end
end
