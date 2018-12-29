class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  include ApplicationHelper


  # Before filters

   # Confirms a logged-in user.
  def logged_in_admin
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to admin_login_url
    end
  end

   # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end 

  # Confirms the correct user and that user exists.
    def correct_user_exists
      user_exist = User.exists?(params[:id])
       if !user_exist
        redirect_to root_url
       else
        @user = User.find(params[:id])   
        redirect_to(root_url) unless current_user?(@user)
       end
    end

    # Can't signup if user already signed in or signed up
    def already_a_user
      if logged_in?
        flash[:danger] = "You're already a user."
        redirect_to customer_user_path(current_user)
      end
    end

    # Confirms a logged-in user.
  def logged_in_customer
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to customer_login_url
    end
  end
end