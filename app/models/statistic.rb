# == Schema Information
#
# Table name: statistics
#
#  id         :bigint           not null, primary key
#  passed     :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  test_id    :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_statistics_on_test_id  (test_id)
#  index_statistics_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (test_id => tests.id)
#  fk_rails_...  (user_id => users.id)
#
class Statistic < ApplicationRecord
  belongs_to :user
  belongs_to :test
end
