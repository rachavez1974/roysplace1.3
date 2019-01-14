class BreakfastsController < ApplicationController
layout "admin_layout", except: :menu
#Other Function definitions live in appplicaiton controller file
before_action :logged_in_admin, except: :menu
before_action :admin_user, except: :menu
before_action :find_item, except: :menu

  def menu
    @breakfasts = Breakfast.where("availability = ?", true)
  end

  def show
      if @item.nil?
      flash.now[:danger] = "Breakfast item not found, please try again!"
      render 'breakfasts/search_form'
    end
  end

  def new
    @item = Breakfast.new
  end

  def create
    @item = Breakfast.new(breakfast_params)
      if @item.save
        flash[:success] = "#{@item.name} was added successfully to breakfast menu!"
        redirect_to @item
      else
        render 'new'
      end
  end

  def edit
  end

  def update
    if @item.update_attributes(breakfast_params)
      flash[:success] = "#{@item.name} information has been updated!" 
      redirect_to @item
    else
      render 'edit'
    end
  end
  
  def destroy
    @item.destroy
    flash[:success] = "The breakfast #{@item.name} has been deleted!"
    redirect_to admin_root_url  
  end

  private

  def breakfast_params
    params.require(:breakfast).permit(:name, :description, :price, :section, :availability)
  end

  def find_item
    @item = Breakfast.find_by("id = ? OR name = ?",  id, name)
  end

  def name
     params[:name]  
  end

  def id
    params[:id]
  end
end
