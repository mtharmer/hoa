# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery

  def create(resource)
    respond_to do |format|
      if resource.save
        format.html { redirect_to resource, notice: I18n.t("#{::Util.pluralize(resource)}.create.notice") }
        format.json { json_success(resource, status: :created) }
      else
        format.html { html_error(:new) }
        format.json { json_error(resource) }
      end
    end
  end

  def update(resource, resource_params)
    respond_to do |format|
      if resource.update(resource_params)
        format.html { redirect_to resource, notice: I18n.t("#{::Util.pluralize(resource)}.update.notice") }
        format.json { json_success(resource) }
      else
        format.html { html_error(:edit) }
        format.json { json_error(resource) }
      end
    end
  end

  def destroy(resource, path)
    resource.destroy!
    respond_to do |format|
      format.html { redirect_to path, status: :see_other, notice: I18n.t("#{::Util.pluralize(resource)}.destroy.notice") }
      format.json { head :no_content }
    end
  end

  protected

  def verify_admin
    return if current_user&.admin?

    flash[:alert] = I18n.t('application.alert')
    redirect_to root_path
  end

  def json_success(resource, template: :show, status: :ok)
    render template, status: status, location: resource
  end

  def html_error(template, status: :unprocessable_entity)
    render template, status: status
  end

  def json_error(resource, status: :unprocessable_entity)
    render json: resource.errors, status: status
  end
end
