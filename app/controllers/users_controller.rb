class UsersController < ApplicationController
  def new
    @user = User.new()
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
      if @user.save
        flash[:success] = "Welcome to Roy's Place!"
        redirect_to @user
      else
        render 'new'
      end    
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
