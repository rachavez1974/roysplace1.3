class CreateHappyHours < ActiveRecord::Migration[5.1]
  def change
    create_table :happy_hours do |t|
      t.string :name
      t.string :description
      t.float :price
      t.boolean :availability
      t.integer :section

      t.timestamps
    end
  end
end
