class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.string :street_address
      t.string :number
      t.string :city
      t.string :state
      t.integer :zipcod
      t.integer :address_type
      t.integer :unit_type
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
