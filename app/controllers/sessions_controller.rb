class SessionsController < ApplicationController

  def new_user_session
  end

  def create_user_session
    @user = User.find_by(email: params[:session][:email].downcase)
      if @user && @user.authenticate(params[:session][:password])  
          log_in(@user)
          #params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
          flash[:success] = "Welcome back #{@user.first_name}"   
          redirect_to root_path
      else
          flash.now[:danger] = 'Invalid email/password combination'
          render  'new_user_session'
      end     
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url

    # if current_user.admin
    # log_out if logged_in?
    #   redirect_to admin_dashboard_url
    # else
    #   log_out if logged_in?
    #   redirect_to root_url
    # end
  end
end
