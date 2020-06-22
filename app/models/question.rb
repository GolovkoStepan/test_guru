# frozen_string_literal: true

# == Schema Information
#
# Table name: questions
#
#  id         :bigint           not null, primary key
#  body       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  test_id    :bigint           not null
#
# Indexes
#
#  index_questions_on_test_id  (test_id)
#
# Foreign Keys
#
#  fk_rails_...  (test_id => tests.id)

class Question < ApplicationRecord
  belongs_to :test
  has_many :answers, dependent: :destroy

  validates :body, presence: true
  validate :answers_count, on: :create

  def correct_answers
    answers.where(correct: true)
  end

  private

  def answers_count
    return if answers.size.in? 1..4

    errors[:base] << 'The number of answers to the question should be in range 1..4'
  end
end
