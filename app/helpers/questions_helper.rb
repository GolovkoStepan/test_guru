module QuestionsHelper
  def question_header(for_view:, title:)
    case for_view
    when :new
      "Create new #{title} question"
    when :edit
      "Edit #{title} question"
    else
      "There is no case for this view [#{for_view}], please create it."
    end
  end
end
