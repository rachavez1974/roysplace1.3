class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone_number
      t.date :birth_day
      t.boolean :text_club
      t.boolean :email_club
      t.boolean :terms

      t.timestamps
    end
  end
end
