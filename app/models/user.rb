class User < ApplicationRecord
  has_many :statistics
  has_many :tests, through: :statistics
  has_many :my_tests, class_name: 'Test', foreign_key: 'user_id'

  enum role: %i[admin regular]

  def tests_by_level(level)
    Test.joins('JOIN statistics ON tests.id = statistics.test_id')
        .where(tests: { level: level }, statistics: { user_id: id })
  end
end
