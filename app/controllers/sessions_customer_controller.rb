class SessionsCustomerController < SessionsController
  
  def new
    super
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
      if @user && @user.authenticate(params[:session][:password])  
          log_in(@user)
          params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
          flash[:success] = "Welcome back #{@user.first_name}"   
          redirect_to root_path
      else
          flash.now[:danger] = 'Invalid email/password combination'
          render  'new'
      end     
  end

  def destroy
    super
  end



end
