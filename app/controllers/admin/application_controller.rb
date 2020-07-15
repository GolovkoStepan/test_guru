module Admin
  class ApplicationController < ActionController::Base
    before_action :authenticate_user!
    before_action :check_admin_role

    layout 'application'

    private

    def check_admin_role
      redirect_to root_path, alert: 'Access to this page is restricted to administrators' unless current_user&.admin?
    end
  end
end
