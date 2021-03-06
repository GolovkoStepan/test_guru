# frozen_string_literal: true

# == Schema Information
#
# Table name: statistics
#
#  id               :bigint           not null, primary key
#  correct_answers  :integer          default(0)
#  success_complete :boolean          default(FALSE)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  question_id      :bigint
#  test_id          :bigint           not null
#  user_id          :bigint           not null
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

class Statistic < ApplicationRecord
  SUCCESS_RATE = 85

  belongs_to :user
  belongs_to :test

  belongs_to :current_question,
             class_name: 'Question',
             foreign_key: 'question_id',
             optional: true

  has_many :issued_badges
  has_many :badges, through: :issued_badges, dependent: :destroy

  before_validation :set_current_question
  after_validation  :set_success_complete_state

  def accept!(answer_ids)
    correct_answers_inc = answer_correct?(answer_ids) ? 1 : 0
    update(correct_answers: correct_answers + correct_answers_inc)
  end

  def success?
    success_rate >= SUCCESS_RATE
  end

  def complete?
    (persisted? && current_question.nil?) || (test.passage_time.present? && seconds_remaining <= 0)
  end

  def success_rate
    complete? ? ((correct_answers.to_f / test.questions.count) * 100).to_i : 0
  end

  def current_question_number
    test.questions.order(:id).where('id <= :question_id', question_id: question_id).count
  end

  def progress
    current_question_number == 1 ? 0 : (100 / (test.questions.count / (current_question_number - 1).to_f)).round
  end

  def seconds_remaining
    test.passage_time.present? ? ((created_at + test.passage_time.seconds) - Time.current).to_i : 0
  end

  private

  def set_success_complete_state
    self.success_complete = success? if persisted?
  end

  def answer_correct?(answer_ids)
    current_question.correct_answers.ids.sort == Array(answer_ids).map(&:to_i).sort
  end

  def set_current_question
    self.current_question = next_question
  end

  def next_question
    if persisted?
      if test.passage_time.present?
        test.questions.order(:id).where('id > ?', current_question.id).first if seconds_remaining.positive?
      else
        test.questions.order(:id).where('id > ?', current_question.id).first
      end
    else
      test.questions.order(:id).first
    end
  end
end
