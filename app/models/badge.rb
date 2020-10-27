# frozen_string_literal: true

# == Schema Information
#
# Table name: badges
#
#  id         :bigint           not null, primary key
#  image      :string
#  name       :string           not null
#  rule       :string           not null
#  rule_value :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Badge < ApplicationRecord
  has_many :issued_badges
  has_many :users, through: :issued_badges

  validates_presence_of :name, :rule
  validates :rule, inclusion: { in: BadgesService::RULES }
  validates :rule_value, presence: true, if: -> { %w[all_by_level all_by_category].include? rule }
  validates_uniqueness_of :rule, scope: :rule_value
end
