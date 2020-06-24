class QuestionsController < ApplicationController
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
    @question = Question.find(params[:id])

    respond_to do |format|
      format.html do
        render inline: <<~ERB
          <div style="border: 4px solid black; padding: 10px; width: 400px; border-radius: 15px;">
            <p>Question id: <%= @question.id %></p>
            <p>Question body: <%= @question.body %></p>
            <p>Answers:</p>
            <% @question.answers.each do |ans| %>
              <div style="border: 2px solid black; padding: 10px; width: 300px; margin-bottom: 10px;  border-radius: 7px;">
                  <p>Answer id: <%= ans.id %></p>
                  <p>Answer body: <%= ans.body %></p>
                  <p>Is correct?: <%= ans.correct %></p>
              </div>
            <% end %>
            <div style="display: flex; justify-content: flex-end">
              <%= link_to 'Destroy question', test_question_path(params[:test_id], params[:id]), method: :delete, data: { confirm: 'Are you sure?' } %>
            </div>
          </div>
        ERB
      end

      format.json { render json: @question }
    end
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
    render plain: params
  end
end
