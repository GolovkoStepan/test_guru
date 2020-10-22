# frozen_string_literal: true

class BadgesService
  SUCCESS_RATE = 85
  RULES = %w[one_try all_by_level_1 all_by_cat_backend].freeze

  attr_reader :user, :test

  def initialize(user:, test:)
    @user = user
    @test = test
  end

  def give_out
    Badge.all.each do |badge|
      next unless respond_to? rule_to_method_name(badge.rule)

      @current_badge = badge
      @user.badges << badge if send rule_to_method_name(badge.rule)
    end
  end

  def one_try?
    @user.statistics
         .joins(:test)
         .where('statistics.result_rate >= :rate', rate: SUCCESS_RATE)
         .where('tests.id = :id', id: @test.id)
         .count == 1
  end

  def all_by_level_1?
    return false if @user.badges.include? @current_badge

    @user.statistics
         .joins(:test)
         .where('statistics.result_rate >= :rate', rate: SUCCESS_RATE)
         .where('tests.level = :level', level: 1)
         .order('tests.id')
         .pluck('tests.id') == Test.where(level: 1).order('tests.id').pluck(:id)
  end

  def all_by_cat_backend?
    return false if @user.badges.include? @current_badge

    category = Category.find_by(title: 'Backend')
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
