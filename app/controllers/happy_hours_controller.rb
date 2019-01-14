class HappyHoursController < ApplicationController
  layout "admin_layout", except: :menu
#Other Function definitions live in appplicaiton controller file
before_action :logged_in_admin, except: :menu
before_action :admin_user, except: :menu
before_action :find_item, except: :menu



  def menu
    @happyhours = HappyHour.where("availability = ?", true)
  end

  def show
    if @item.nil?
      flash.now[:danger] = "Happy Hour item not found, please try again!"
      render 'happy_hours/search_form'
    end
  end

  def new
    @item = HappyHour.new
  end

  def create
    @item = HappyHour.new(happy_hour_params)
      if @item.save
        flash[:sucess] = "#{@item.name} was added successfully to happy hour menu!"
        redirect_to @item
      else
          render 'new'
      end
    
  end

  def edit
  end

  def update
    if @item.update_attributes(happy_hour_params)
      flash[:sucess] = "#{@item.name} information has been updated!"
      redirect_to @item
    else
      render 'edit'
    end
  end

  def destroy
    @item.destroy
    flash[:sucess] = "The happy hour #{@item.name} has been deleted!" 
    redirect_to admin_root_url
  end

  private
  def happy_hour_params
    params.require(:happy_hour).permit(:name, :description, :price, :availability)
  end

  def find_item
    @item = HappyHour.find_by("id = ? OR name = ?", id, name)
  end

  def id
    params[:id]    
  end

  def name
    params[:name]
  end
end
