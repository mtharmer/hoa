# frozen_string_literal: true

class RegistrationsController < Devise::RegistrationsController
  def profile
    render 'devise/registrations/profile', locals: { resource: current_user }
  end

  def update_profile
    resource_updated = current_user.update(profile_update_params)
    if resource_updated
      redirect_to root_path, notice: I18n.t('registrations.update_profile.notice')
    else
      respond_with resource, location: edit_user_registration_path, alert: I18n.t('registrations.update_profile.alert')
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

  def profile_update_params
    params.require(:user).permit(:email, :name, :address_id)
  end
end
