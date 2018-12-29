class Admin::PasswordResetsController < ApplicationController
  layout "admin_layout"
  before_action  :get_user,   only: [:edit, :update]
  before_action  :valid_user, only: [:edit, :update]
  before_action  :check_expiration, only: [:edit, :update] 

  def new
  end

  def create
     @user = User.find_by(email: params[:password_reset][:email].downcase)
      if @user
        if @user.activated?
          @user.create_reset_digest
          @user.send_password_reset_email
          flash[:info] = "Email sent with password reset instructions"
          redirect_to admin_root_url
        else
          message  = "Account not activated."
          message += "Check your email for the activation link."
          flash[:warning] = message
          redirect_to root_url
        end
      else
        flash.now[:danger] = "Email address not found"
        render 'new'
      end
 end

  def edit


  end

  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, "can't be empty")
      render 'edit'
    elsif @user.update_attributes(user_params)  
      log_in(@user)
      @user.update_attribute(:reset_digest, nil)
      flash[:success] = "#{@user.first_name}, your password has been reset."
      redirect_to admin_user_url(@user)
    else
      render 'edit'
    end       
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def get_user
    @user = User.find_by(email: params[:email])
  end

  # confirms a valid user
  def valid_user
    unless (@user && @user.activated?   &&   
            @user.authenticated?(:reset, params[:id])) 
      redirect_to admin_root_url
    end
  end

  def check_expiration
    if @user.password_reset_expired?
      flash[:danger] = "Password reset has expired, please use (forgot password) again."
      redirect_to new_admin_password_reset_url
    end
  end

end
