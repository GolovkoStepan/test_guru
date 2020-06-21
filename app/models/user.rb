class User < ApplicationRecord
  has_many :statistics, dependent: :destroy
  has_many :tests, through: :statistics
  has_many :my_tests, class_name: 'Test', foreign_key: 'user_id', dependent: :destroy

  enum role: %i[admin regular]

  def tests_by_level(level)
    tests.by_level(level)
  end
end
