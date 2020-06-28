class QuestionsController < ApplicationController
  before_action :find_question, only: %i[show edit update destroy]

  def show; end

  def new
    @test = Test.find(params[:test_id])
    @question = Question.new
  end

  def create
    @test = Test.find(params[:test_id])
    @question = @test.questions.new(question_params)

    if @question.save
      redirect_to question_path(@question)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @question.update(question_params)
      redirect_to question_path(@question)
    else
      render :edit
    end
  end

  def destroy
    @question.destroy

    redirect_to test_path(@question.test.id)
  end

  private

  def find_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:body)
  end
end
