class User < ApplicationRecord
  def tests_by_level(level)
    Test.joins('JOIN statistics ON tests.id = statistics.test_id')
        .where(tests: { level: level }, statistics: { user_id: id })
  end
end
