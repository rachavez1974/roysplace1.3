class Customer::AccountActivationsController < ApplicationController
  def edit
    @user = User.find_by(email: params[:email])
    if @user && !@user.activated? && @user.authenticated?(:activation, params[:id])
      @user.activate
      log_in @user
      flash[:success] = "Welcome to Roy's Place, your account is activated, visit our menus so we can take your order!"
      redirect_to customer_user_url(@user)
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
  end
end
