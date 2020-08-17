# frozen_string_literal: true

# == Schema Information
#
# Table name: answers
#
#  id          :bigint           not null, primary key
#  body        :string           not null
#  correct     :boolean          default(FALSE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  question_id :bigint           not null
#
# Indexes
#
#  index_answers_on_question_id  (question_id)
#
# Foreign Keys
#
#  fk_rails_...  (question_id => questions.id)

class Answer < ApplicationRecord
  belongs_to :question

  validates :body, presence: true
  validate :min_count, on: :create

  scope :correct, -> { where(correct: true) }

  private

  def min_count
    return if question.answers.count < 4

    errors[:base] << 'The number of answers to the question should be less than 4'
  end
end
