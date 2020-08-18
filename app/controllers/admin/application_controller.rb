# frozen_string_literal: true

module Admin
  class ApplicationController < ::ApplicationController
    before_action :check_admin_role

    layout 'admin_layout'

    private

    def check_admin_role
      redirect_to root_path, alert: t('messages.admin_only') unless current_user.admin?
    end
  end
end
