# frozen_string_literal: true

class BadgesController < ApplicationController
  def index
    @all_badges  = Badge.all.page(params[:all_badges_page])
    @user_badges = current_user.badges.page(params[:user_badges_page])
  end
end
