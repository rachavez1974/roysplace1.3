class LunchesController < ApplicationController
layout "admin_layout"
#Other Function definitions live in appplicaiton controller file
before_action :logged_in_admin
before_action :admin_user
before_action :find_item


  def menu
  end

  def show
    if @item.nil?
      flash.now[:danger] = "Lunch item not found, please try again!"
      render 'lunches/search_form'
    end
  end

  def new
    @item = Lunch.new
  end

  def create
    @item = Lunch.new(lunch_params)
      if @item.save
        flash[:success] = "#{@item.name} was added successfully to lunch menu!"
        redirect_to @item
      else
        render 'new'
      end
  end

  def edit
  end

  def update
    if @item.update_attributes(lunch_params)
      flash[:success] = "#{@item.name} information has been updated!" 
      redirect_to @item
    else
      render 'edit'
    end   
  end

  def destroy
    @item.destroy
    flash[:success] = "The lunch item #{@item.name} has been deleted!"
    redirect_to admin_root_url
    
  end

  private
    def lunch_params
      params.require(:lunch).permit(:name, :description, :price, :section, :availability)
    end

    def find_item
    @item = Lunch.find_by("id = ? OR name = ?",  id, name)
    end

    def name
       params[:name]  
    end

    def id
      params[:id]
    end 
  


end
