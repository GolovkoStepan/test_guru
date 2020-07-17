# frozen_string_literal: true

module Users
  class SessionsController < Devise::SessionsController
    def create
      super do
        usr_msg = "Hi, #{current_user.username}! Tests were waiting..."
        adm_msg = "Hi, #{current_user.username}! Welcome back to your nice admin panel!"
        flash[:notice] = current_user.admin? ? adm_msg : usr_msg
      end
    end
  end
end
