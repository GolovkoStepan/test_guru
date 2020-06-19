class User < ApplicationRecord
  def tests_by_level(level)
    Test.joins('JOIN statistics ON tests.id = statistics.test_id')
        .where('statistics.user_id = :id AND tests.level = :level', id: id, level: level)
  end
end
