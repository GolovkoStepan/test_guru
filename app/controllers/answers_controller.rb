class AnswersController < ApplicationController
  before_action :find_answer, only: %i[edit update destroy]

  def new
    @question = Question.find(params[:question_id])
    @answer = Answer.new(question: @question)
  end

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(answer_params)

    if @answer.save
      redirect_to question_path(@question)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @answer.update(answer_params)
      redirect_to question_path(@answer.question_id)
    else
      render :edit
    end
  end

  def destroy
    @answer.destroy

    redirect_to question_path(@answer.question_id)
  end

  private

  def find_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body, :correct)
  end
end
