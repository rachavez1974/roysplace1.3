class RemoveSectionFromHappyhours < ActiveRecord::Migration[5.1]
  def change
    remove_column :happy_hours, :section
  end
end
