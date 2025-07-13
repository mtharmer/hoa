# frozen_string_literal: true

class RegistrationsController < Devise::RegistrationsController
  def update
    resource_updated = current_user.update(account_update_params)
    if resource_updated
      redirect_to root_path, notice: I18n.t('registrations.update.notice')
    else
      respond_with resource, location: edit_user_registration_path, alert: I18n.t('registrations.update.alert')
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :name, :address_id)
  end

  # Stub the sign_up method to always return true.
  # This prevents automatic login after sign-up, as we require admin approval to unlock accounts.
  def sign_up(_resource_name, _resource) # rubocop:disable Naming/PredicateMethod
    true
  end

  def account_update_params
    params.require(:user).permit(:email, :name, :address_id)
  end
end
