class Answer < ApplicationRecord
  belongs_to :question

  scope :correct, ->(question) { where(question: question, correct: true) }
end
