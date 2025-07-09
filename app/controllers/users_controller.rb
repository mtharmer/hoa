# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_admin

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
    user
  end

  # GET /users/1/edit
  def edit
    user
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    user.update(user_params)
    respond_to do |format|
      format.html { redirect_to user, notice: I18n.t('users.update.notice') }
      format.json { render :show, status: :ok, location: user }
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    user.destroy!

    respond_to do |format|
      format.html { redirect_to users_path, status: :see_other, notice: I18n.t('users.destroy.notice') }
      format.json { head :no_content }
    end
  end

  private

  # Memoize the user lookup to avoid multiple database queries.
  def user
    @user ||= User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:admin, :locked)
  end
end
