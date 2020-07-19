# frozen_string_literal: true

module Users
  class SessionsController < Devise::SessionsController
    def create
      super do
        flash[:notice] = t('messages.greetings', username: current_user.username )
      end
    end
  end
end
