# frozen_string_literal: true

module Admin
  class GistsController < Admin::ApplicationController
    before_action :find_gist, only: %i[destroy]

    def index
      @gists = Gist.all
    end

    def destroy
      result = github_service.remove_gist gist_id: @gist.gist_id

      if result.success
        redirect_to admin_gists_path, notice: t('messages.gist_remove_success')
      else
        redirect_to admin_gists_path, alert: t('messages.gist_remove_fail')
      end
    end

    private

    def find_gist
      @gist = Gist.find(params[:id])
    end

    def github_service
      @github_service ||= GithubService.new
    end
  end
end
