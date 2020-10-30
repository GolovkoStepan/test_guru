# frozen_string_literal: true

class TestsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  before_action :find_test, only: :start

  def index
    @tests = Test.all.page(params[:page])
  end

  def start
    current_user.tests << @test
    redirect_to current_user.statistic(@test)
  end

  private

  def find_test
    @test = Test.find(params[:id])
  end

  def test_params
    params.require(:test).permit(:title, :category_id, :level)
  end
end
