class ChangeZipcodToZipcodeTonAddress < ActiveRecord::Migration[5.1]
  def change
    rename_column :addresses, :zipcod, :zipcode
  end
end
