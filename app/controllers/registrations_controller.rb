# frozen_string_literal: true

class RegistrationsController < Devise::RegistrationsController
  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :name, :address_id)
  end
end
