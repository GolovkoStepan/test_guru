# frozen_string_literal: true

# == Schema Information
#
# Table name: issued_badges
#
#  id           :bigint           not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  badge_id     :bigint           not null
#  statistic_id :bigint           not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_issued_badges_on_badge_id      (badge_id)
#  index_issued_badges_on_statistic_id  (statistic_id)
#  index_issued_badges_on_user_id       (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (badge_id => badges.id)
#  fk_rails_...  (statistic_id => statistics.id)
#  fk_rails_...  (user_id => users.id)
#
class IssuedBadge < ApplicationRecord
  belongs_to :badge
  belongs_to :user
  belongs_to :statistic
end
