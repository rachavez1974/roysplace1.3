class Admin::DashboardController < ApplicationController
  layout "admin_layout"
  before_action :logged_in_admin, except: [:home]
  before_action :admin_user, except: [:home]

  def home
  end

  def add_new_menu_items
    
  end

  def update_menu_items
    
  end

  def search_menu_items
    
  end
  
  def delete_menu_items
    
  end
  
end
