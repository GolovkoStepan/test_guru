# frozen_string_literal: true

class BadgesService
  SUCCESS_RATE = 85
  RULES = %w[one_try all_by_level all_by_category].freeze

  attr_reader :user, :test

  def initialize(user:, test:)
    @user = user
    @test = test
  end

  def give_out
    Badge.all.each do |badge|
      next unless respond_to? rule_to_method_name(badge.rule)

      @current_badge = badge
      yield(badge) if send(rule_to_method_name(badge.rule), badge.rule_value)
    end
  end

  def one_try?(_)
    @user.statistics
         .joins(:test)
         .where('statistics.result_rate >= :rate', rate: SUCCESS_RATE)
         .where('tests.id = :id', id: @test.id)
         .count == 1
  end

  def all_by_level?(level)
    return false if @user.badges.include? @current_badge

    @user.statistics
         .joins(:test)
         .where('statistics.result_rate >= :rate', rate: SUCCESS_RATE)
         .where('tests.level = :level', level: level.to_i)
         .order('tests.id')
         .pluck('tests.id') == Test.where(level: level.to_i).order('tests.id').pluck(:id)
  end

  def all_by_category?(category_name)
    return false if @user.badges.include? @current_badge

    category = Category.find_by(title: category_name)
    @user.statistics
         .joins(:test)
         .where('statistics.result_rate >= :rate', rate: SUCCESS_RATE)
         .where('tests.category_id = :id', id: category.id)
         .order('tests.id')
         .pluck('tests.id')
         .uniq == Test.where('category_id = :id', id: category.id)
                      .order('tests.id')
                      .pluck('tests.id')
                      .uniq
  end

  private

  def rule_to_method_name(rule)
    "#{rule}?".to_sym
  end
end
