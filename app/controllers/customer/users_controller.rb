class Customer::UsersController < ApplicationController
   #Function definitions live in appplicaiton controller file
   before_action :logged_in_customer,     only: [:edit, :update, :show, :destroy]
   before_action :correct_user_exists,    only: [:edit, :update, :show, :destroy]
   before_action :already_a_user,         only: [:new, :create]


  def new
    @user = User.new()
  end

  def show
    if @user.admin?
      render :layout => "admin_layout"
    end
  end

  def create
    @user = User.new(user_params)
      if @user.save
        @user.send_activation_email
        flash[:info] = "Welcome to Roy's Place, please check your email to activate your account!"
        redirect_to root_url
      else
        render 'new'
      end     
  end

  def edit
    if @user.admin?
      render :layout => "admin_layout"
    end
  end

  def update  
    if @user.update_attributes(user_params)
      flash[:success] = "Your profile has been updated!" 
      redirect_to customer_user_url(@user)
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    flash[:success] = "The account for #{@user.first_name} has been deleted!"
    redirect_to root_url
  end


  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :phone_number, 
                :birth_day, :email, :password, :password_confirmation,
                :text_club, :email_club, :terms)
                #, :addresses_attributes => [:id, :street_address, :address_type, :unit_type, :city, :state,
                #:zipcode, :number, :user_id])
  end
   
   
end
