class Question < ApplicationRecord
  belongs_to :test
  has_many :answers, dependent: :destroy

  def correct_answers
    answers.where(correct: true)
  end
end
