# frozen_string_literal: true

class RegistrationsController < Devise::RegistrationsController
  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :name, :address_id)
  end

  # Stub the sign_up method to always return true.
  # This prevents automatic login after sign-up, as we require admin approval to unlock accounts.
  def sign_up(_resource_name, _resource) # rubocop:disable Naming/PredicateMethod
    true
  end
end
