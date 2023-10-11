# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  include RackSessionFix

  before_action :authenticate_user!, only: [:update, :destroy, :index]

  after_action :send_mail_to_admin, only: [:create]

  respond_to :json
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end
  def index
    # @users=order(created_at: :desc)
    # if current_user.has_role? "admin"
    #   @user=User.order(created_at: :desc)
    #   render json: @user
    # else
    #   render plain: "You are not admin"
    # end
  end

  # POST /resource
  def create
    @user=User.create(user_params)
    @admin_user = User.find_by(role: "admin") 
    if @user.save
      CommentNotification.with(user: @user).deliver_later(@user)
      # CrudNotificationMailer.with(user: @user).comment_notification.deliver_now
      render json: @user
    else
      render json: @user.errors
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  def update
    @user=current_user
    if @user.update(user_params)
      CrudNotificationMailer.update_notification(@user).deliver_now
      render json: current_user
    else
      render json: @user.errors
    end
  end

  # DELETE /resource
  def destroy
    @user=current_user
    CrudNotificationMailer.delete_notification(@user).deliver_now
    @user.destroy
    render plain: "deleted successfully"
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  private

  def send_mail_to_admin
    # User.find_each do |user|
    @user=User.find_by(role: "admin")
    CommentNotification.with(user: @user).deliver_later(current_user)
  end


  def user_params
    params.require(:user).permit(:email,:password)
  end

  def respond_with(resource, _opts={})
   
    if request.method == 'POST' && resource.persisted?
      render json: {
        status: {code:200, message:"signed up successfully", data: resource}
      }
    elsif request.method == 'DELETE'
      render json: {
        status: {code:200, message: "Account deleted successfully"}
      }, status: :ok
    else
      render json: {
        status: {message: "user could not be created successfylly", 
      errors: resource.errors.full_messages}
      }, status: :unprocessable_entity
    end
  end
end
