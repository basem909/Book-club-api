# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # POST /resource
  def create
    @user = User.new(name: params[:name], password: params[:password],
      password_confirmation: params[:password_confirmation], email: params[:email])
    if @user.save
      render json: { status: 'Success', message: 'created users', data: @user }, status: :ok
    else
      render json: {
      status: 422,
      message: 'Registration failed'
      }, status: 422
    end
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  end
end
