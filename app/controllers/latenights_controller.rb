class LatenightsController < ApplicationController
layout "admin_layout"
#Other Function definitions live in appplicaiton controller file
before_action :logged_in_admin
before_action :admin_user
before_action :find_item


  def menu
  end

  def show
    if @item.nil?
      flash.now[:danger] = "Late Nigth item not found, please try again!"
      render 'latenights/search_form'
    end
  end

  def new
    @item = Latenight.new
  end

  def create
    @item = Latenight.new(latenight_params)
      if@item.save
        flash[:sucess] = "#{@item.name} was added successfully to late night menu!"
        redirect_to @item
      else
        render 'new'
      end
  end

  def edit
  end

  def update
    if @item.update_attributes(latenight_params)
      flash[:sucess] = "#{@item.name} information has been updated!"
      redirect_to @item
    else
      render 'edit'
    end
  end

  def destroy
    @item.destroy
    flash[:sucess] = "The late night #{@item.name} has been deleted!" 
    redirect_to admin_root_url
  end

  private
    def latenight_params
      params.require(:latenight).permit(:name, :description, :price, :availability, :section)
    end

    def find_item
      @item = Latenight.find_by("id = ? OR name = ?", id, name)
    end

    def name
      params[:name]
    end

    def id
      params[:id]
    end
end
