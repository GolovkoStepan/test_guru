class StatisticsController < ApplicationController
  before_action :find_statistic

  def show; end

  def result; end

  def update
    @statistic.accept!(params[:answer_ids])

    if @statistic.complete
      redirect_to result_statistic_path(@statistic)
    else
      render :show
    end
  end

  private

  def find_statistic
    @statistic = Statistic.find(params[:id])
  end
end
