class QuestionsController < ApplicationController
  before_action :find_question, only: %i[show destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :find_error_response

  def index
    @questions = Test.find(params[:test_id]).questions

    respond_to do |format|
      format.html do
        render inline: <<~ERB
          <p><%= link_to 'Create new question', new_test_question_path(params[:test_id]) %></p>
          <% @questions.each do |q| %>
            <div style="border: 4px solid black; padding: 10px; width: 400px; margin-bottom: 10px; border-radius: 15px;">
              <p>Question id: <%= q.id %></p>
              <p><%= link_to "Go to question", test_question_path(params[:test_id], q) %></p>
            </div>
          <% end %>
        ERB
      end

      format.json { render json: @questions }
    end
  end

  def show
    render file: 'questions/show'
  end

  def new
    render inline: <<~ERB
      <div style="border: 4px solid black; padding: 10px; width: 400px; border-radius: 15px;">
        <p>Create new questions for test id: <%= params[:test_id] %></p>
        <form action=<%= test_questions_path %> method="post">
          <input name="authenticity_token" value="<%= form_authenticity_token %>" type="hidden">
          <p>Body: <input type="text" name="body"></p>
          <div style="display: flex; justify-content: flex-end">
            <input type="submit">
            <%= link_to 'Back', :back %>
          </div>
        </form>
      </div>
    ERB
  end

  def create
    question_params = params.permit(:test_id, :body)
    @question = Question.new(question_params)

    if @question.valid?
      @question.save!
      render inline: <<~ERB
        <p>Question created</p>
        <p><%= link_to "Go to question", test_question_path(params[:test_id], @question) %></p>
      ERB
    else
      render inline: <<~ERB
        <p>Error creating question</p>
        <p>Messages: <%= @question.errors.full_messages %></p>
        <%= link_to 'Back', :back %>
      ERB
    end
  end

  def destroy
    @question.destroy

    redirect_to test_questions_path
  end

  private

  def find_question
    @question = Question.find_by!(test_id: params[:test_id], id: params[:id])
  end

  def find_error_response
    render plain: 'Record not found'
  end
end
