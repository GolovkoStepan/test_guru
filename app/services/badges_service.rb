# frozen_string_literal: true

class BadgesService
  SUCCESS_RATE = 85
  RULES = %w[one_try all_by_level all_by_category].freeze

  attr_reader :user, :test

  def initialize(user:, test:)
    @user = user
    @test = test
  end

  def badges_for_give_out
    Badge.all.map do |badge|
      next unless respond_to? rule_to_method_name(badge.rule)

      badge if send(rule_to_method_name(badge.rule), badge.rule_value)
    end.compact
  end

  def give_the_user
    @user.badges += badges_for_give_out
  end

  def one_try?(_)
    @user.statistics
         .joins(:test)
         .where('tests.id = :id', id: @test.id)
         .count == 1
  end

  def all_by_level?(level)
    return unless @test.level == level.to_i

    stats = @user.statistics
                 .joins(:test)
                 .where('statistics.result_rate >= :rate', rate: SUCCESS_RATE)
                 .where('tests.level = :level', level: level.to_i)
                 .group('tests.id')
                 .order('tests.id')
                 .select('tests.id as id, count(tests.id) as count')

    stats.map { |stat| { id: stat.id, count: stat.count } }

    tests_ids = Test.where(level: level.to_i).order('tests.id').pluck(:id)
    return false unless tests_ids == stats.map { |stat| stat[:id] }

    stats.map { |stat| stat[:count] }.uniq.count == 1
  end

  def all_by_category?(category_name)
    return unless @test.category.title == category_name

    category = Category.find_by(title: category_name)

    stats = @user.statistics
                 .joins(:test)
                 .where('statistics.result_rate >= :rate', rate: SUCCESS_RATE)
                 .where('tests.category_id = :id', id: category.id)
                 .group('tests.id')
                 .order('tests.id')
                 .select('tests.id as id, count(tests.id) as count')

    stats.map { |stat| { id: stat.id, count: stat.count } }

    tests_ids = Test.where(category: category).order('tests.id').pluck('tests.id')
    return false unless tests_ids == stats.map { |stat| stat[:id] }

    stats.map { |stat| stat[:count] }.uniq.count == 1
  end

  private

  def rule_to_method_name(rule)
    "#{rule}?".to_sym
  end
end
