# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery

  protected

  def verify_admin
    return if current_user&.admin?

    flash[:alert] = I18n.t('application.alert')
    redirect_to root_path
  end
end
