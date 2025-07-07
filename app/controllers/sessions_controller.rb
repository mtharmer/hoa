# frozen_string_literal: true

class SessionsController < Devise::SessionsController
  before_action :check_unlocked, only: [:create] # rubocop:disable Rails/LexicallyScopedActionFilter

  private

  def check_unlocked
    return unless params[:user] && params[:user][:email]

    user = User.find_by(email: params[:user][:email])
    if user&.locked
      flash[:alert] = I18n.t('devise.sessions.locked')
      redirect_to new_user_session_path
    else
      true
    end
  end
end
