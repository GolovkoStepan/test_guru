# frozen_string_literal: true

# == Schema Information
#
# Table name: badges
#
#  id         :bigint           not null, primary key
#  image      :string
#  name       :string           not null
#  rule       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Badge < ApplicationRecord
  RULES = {
    first_test: 'Выдать бэйдж после успешного прохождения первого теста',
    one_try: 'Выдать бэйдж после успешного прохождения теста с первой попытки',
    all_by_level_1: 'Выдать бэйдж после успешного прохождения всех тестов 1 уровня'
  }.with_indifferent_access.freeze

  has_and_belongs_to_many :users

  validates_presence_of :name, :rule

  def self.give_out(user, test)
    all.each { |badge| user.badges << badge if badge.can_be_issued?(user, test) }
  end

  def can_be_issued?(user, test)
    case rule
    when 'first_test'
      statistic = Statistic.by_user(user).to_a
      statistic = statistic.select(&:success?)
      statistic.count == 1
    when 'one_try'
      statistic = Statistic.by_user(user).by_test(test).to_a
      success = statistic.select(&:success?)
      statistic.count == 1 && success.count == 1
    when 'all_by_level_1'
      test_1_level = Test.where level: 1
      statistic = Statistic.by_user(user).where('test_id IN (:test_ids)', test_ids: test_1_level.ids)
      statistic = statistic.select(&:success?)
      statistic.count == test_1_level.count && user.badges.where(rule: rule).none?
    else
      false
    end
  end
end
