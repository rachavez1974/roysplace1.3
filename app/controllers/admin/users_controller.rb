class Admin::UsersController < ApplicationController
  layout "admin_layout"
  #Other Function definitions live in appplicaiton controller file
  before_action :logged_in_admin
  before_action :admin_user
  before_action :find_customer


  def new
    @user = User.new()
  end

  def show
    if @user.nil?
      flash.now[:danger] = "Customer not found, please try again!"
      render 'admin/users/search_form'
    end
  end

  def create
    @user = User.new(user_params)
  
      if @user.save(validate: false)
        flash[:info] = "#{@user.first_name} was added!"
        redirect_to admin_user_url(@user)
      else
        render 'new'
      end     
  end

  def edit
  end

  def update
    @user.attributes = user_params
    if @user.save(validate: false)
      flash[:success] = "#{@user.first_name} profile has been updated!" 
      redirect_to admin_user_url(@user)
    else
      render 'edit'
    end
  end

  def destroy 
    @user.destroy
    flash[:success] = "The account for #{@user.first_name} has been deleted!"
    redirect_to admin_dashboard_home_url
  end


  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :phone_number, 
                :birth_day, :email, :password, :password_confirmation,
                :text_club, :email_club, :terms)
                #, :addresses_attributes => [:id, :street_address, :address_type, :unit_type, :city, :state,
                #:zipcode, :number, :user_id])
  end
 
  def find_customer
    @user = User.find_by("id = ? OR phone_number = ? Or email = ?",  id, phone, email)
  end

  def phone
     params[:phone_number]  
  end

  def id
    params[:id]
  end

  def email
     params[:email]
  end
end
