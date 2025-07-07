# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protected

  def verify_admin!
    return if current_user&.admin?

    flash[:alert] = 'You must be an admin to perform this action.'
    redirect_to root_path
  end
end
