# == Schema Information
#
# Table name: statistics
#
#  id              :bigint           not null, primary key
#  correct_answers :integer          default(0)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  question_id     :bigint
#  test_id         :bigint           not null
#  user_id         :bigint           not null
#
# Indexes
#
#  index_statistics_on_question_id  (question_id)
#  index_statistics_on_test_id      (test_id)
#  index_statistics_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (question_id => questions.id)
#  fk_rails_...  (test_id => tests.id)
#  fk_rails_...  (user_id => users.id)
#
require 'test_helper'

class StatisticTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
