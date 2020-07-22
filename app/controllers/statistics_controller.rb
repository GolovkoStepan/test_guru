class StatisticsController < ApplicationController
  before_action :find_statistic

  def show; end

  def result; end

  def update
    @statistic.accept!(params[:answer_ids])

    if @statistic.complete?
      redirect_to result_statistic_path(@statistic)
    else
      render :show
    end
  end

  def create_gist
    result = github_client.create_question_gist(
      user: current_user,
      question: @statistic.current_question
    )

    if result
      redirect_to statistic_path(@statistic), notice: t('messages.gist_create_success', url: result.html_url)
    else
      redirect_to statistic_path(@statistic), alert: t('messages.gist_create_fail')
    end
  end

  private

  def find_statistic
    @statistic = Statistic.find(params[:id])
  end
  
  def github_client
    @github_client ||= GithubService.new
  end
end
