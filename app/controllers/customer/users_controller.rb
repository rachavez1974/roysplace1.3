class Customer::UsersController < ApplicationController
   before_action :logged_in_user,         only: [:edit, :update, :show, :destroy]
   before_action :correct_user_exists,    only: [:edit, :update, :show, :destroy]
   before_action :already_a_user,         only: [:new, :create]


  def new
    @user = User.new()
  end

  def show
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
  end

  def update  
    if @user.update_attributes(user_params)
      flash[:success] = "Your profile has been update!" 
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
   
   # Before filters

   # Confirms a logged-in user.
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to customer_login_url
    end
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

end
