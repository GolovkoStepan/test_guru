module QuestionsHelper
  # TODO: remove it after testing localization
  def question_header(question)
    if question.new_record?
      "Create new #{question.test.title} question"
    else
      "Edit #{question.test.title} question"
    end
  end
end
