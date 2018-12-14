class Admin::SessionsController < ApplicationController
layout "admin_layout"

  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
      if @user && @user.admin? && @user.authenticate(params[:session][:password]) 
          if @user.activated? 
          log_in(@user)
          params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
          flash[:success] = "Welcome back #{@user.first_name}"   
          redirect_back_or admin_dashboard_home_url
        else
          message  = "Account not activated."
          message += "Please check with your network manager."
          flash[:warning] = message
          redirect_to admin_login_url
        end
      else
          flash.now[:danger] = 'Invalid email/password combination for admin.'
          render  'new'
      end     
  end

  def destroy
    log_out if logged_in?
    redirect_to admin_login_url
  end
end
