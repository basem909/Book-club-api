# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  skip_before_action :verify_signed_out_user

  # POST /resource/sign_in
  def create
    @user = User.find_by(email: params['email'])

    if @user.valid_password?(params[:password])
      sign_in(@user)
      render json: { status: 'Success', message: 'signed in', data: @user }, status: :ok
    else
      render json: { status: 'failed', message: 'unauthorized' }, status: 401
    end
  end

  # DELETE /resource/sign_out
  def destroy
    @user = current_user
    if @user
      render json: { status: 'Success', message: 'signed out', data: @user }, status: 200
      sign_out(@user)
    else
      render json: { status: 'Failed', message: 'There is no user to sign out' }, status: :unauthorized
    end
  end
end
