# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id          :bigint           not null, primary key
#  email       :string           not null
#  first_name  :string           not null
#  last_name   :string           not null
#  middle_name :string
#  role        :integer          default("regular")
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class User < ApplicationRecord
  has_many :statistics, dependent: :destroy
  has_many :tests, through: :statistics
  has_many :my_tests, class_name: 'Test', foreign_key: 'user_id', dependent: :destroy

  validates :first_name, :last_name, :email, presence: true

  enum role: %i[admin regular]

  def tests_by_level(level)
    tests.by_level(level)
  end

  def statistic(test)
    statistics.order(id: :desc).find_by(test_id: test.id)
  end
end
