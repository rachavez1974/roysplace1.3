class CreateLatenights < ActiveRecord::Migration[5.1]
  def change
    create_table :latenights do |t|
      t.string :name
      t.string :description
      t.float :price
      t.boolean :availability
      t.integer :section

      t.timestamps
    end
  end
end
