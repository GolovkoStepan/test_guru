# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string
#  last_name              :string
#  middle_name            :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :integer          default("regular")
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  has_many :statistics, dependent: :destroy
  has_many :tests, through: :statistics
  has_many :my_tests, class_name: 'Test', foreign_key: 'user_id', dependent: :destroy
  has_many :gists, dependent: :destroy
  has_many :issued_badges
  has_many :badges, through: :issued_badges, dependent: :destroy

  validates_presence_of :first_name, :last_name

  enum role: %i[admin regular]

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :confirmable

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
