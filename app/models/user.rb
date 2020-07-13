# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string           not null
#  first_name      :string           not null
#  last_name       :string           not null
#  middle_name     :string
#  password_digest :string           not null
#  role            :integer          default("regular")
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#

class User < ApplicationRecord
  has_many :statistics, dependent: :destroy
  has_many :tests, through: :statistics
  has_many :my_tests, class_name: 'Test', foreign_key: 'user_id', dependent: :destroy

  has_secure_password

  validates :first_name, :last_name, :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates_uniqueness_of :email

  enum role: %i[admin regular]

  def username
    [first_name, last_name].map(&:capitalize).join(' ')
  end

  def tests_by_level(level)
    tests.by_level(level)
  end

  def statistic(test)
    statistics.order(id: :desc).find_by(test_id: test.id)
  end
end
