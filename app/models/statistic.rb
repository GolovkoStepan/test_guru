# frozen_string_literal: true

# == Schema Information
#
# Table name: statistics
#
#  id              :bigint           not null, primary key
#  complete        :boolean          default(FALSE)
#  correct_answers :integer          default(0)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  question_id     :bigint           not null
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

class Statistic < ApplicationRecord
  belongs_to :user
  belongs_to :test
  belongs_to :current_question, class_name: 'Question', foreign_key: 'question_id'

  before_validation :setup_current_question, on: :create
  before_update :setup_next_question

  def accept!(answer_ids)
    self.correct_answers += 1 if answer_correct?(answer_ids)
    save!
  end

  def success_rate
    return 0 unless complete

    ((correct_answers.to_f / test.questions.count) * 100).to_i
  end

  def current_question_number
    test.questions.order(:id).ids.index(question_id) + 1
  end

  private

  def answer_correct?(answer_ids)
    current_question.correct_answers.ids.sort == answer_ids.map(&:to_i).sort
  end

  def next_question
    test.questions.order(:id).where('id > ?', current_question.id).first
  end

  def setup_current_question
    self.current_question = test.questions.first if test.present?
  end

  def setup_next_question
    if current_question == test.last_question
      self.complete = true
    else
      self.current_question = next_question
    end
  end
end
