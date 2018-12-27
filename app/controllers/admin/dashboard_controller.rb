class Admin::DashboardController < ApplicationController
  layout "admin_layout"
  before_action :logged_in_admin, except: [:home]
  before_action :admin_user, except: [:home]

  def home
  end

  def add_new_breakfast_items
    
  end

  def update_breakfast_items
    
  end

  def search_breakfast_items
    
  end
  
  def delete_breakfast_items
    
  end
  
end
