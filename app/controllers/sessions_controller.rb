class SessionsController < ApplicationController

  def new
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
