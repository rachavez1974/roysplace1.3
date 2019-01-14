class BrunchesController < ApplicationController
layout "admin_layout", except: :menu
#Other Function definitions live in appplicaiton controller file
before_action :logged_in_admin, except: :menu
before_action :admin_user, except: :menu
before_action :find_item, except: :menu


  def menu
    @brunches = Brunch.where("availability = ?", true)
  end

  def show
    if @item.nil?
      flash.now[:danger] = "Brunch item not found, please try again!"
      render 'brunches/search_form'
    end
  end

  def new
    @item = Brunch.new
  end

  def create
    @item = Brunch.new(brunch_params)
      if @item.save 
        flash[:sucess] = "#{@item.name} was added successfully to brunch menu!"
        redirect_to @item
      else
        render 'new'
      end
  end

  def edit
  end

  def update
    if @item.update_attributes(brunch_params)
      flash[:sucess] = "#{@item.name} information has been updated!" 
      redirect_to @item
    else
      render 'edit'
    end
  end

  def destroy
    @item.destroy
      flash[:sucess] = "The brunch #{@item.name} has been deleted!"
      redirect_to admin_root_url
  end

  private
  def brunch_params
    params.require(:brunch).permit(:name, :description, :price, :availability, :section)
  end

  def find_item
    @item = Brunch.find_by("id = ? OR name = ?", id, name)
  end

  def id
    params[:id]    
  end

  def name
    params[:name]
  end


end
