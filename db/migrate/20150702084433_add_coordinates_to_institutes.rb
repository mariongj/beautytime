class AddCoordinatesToInstitutes < ActiveRecord::Migration
  def change
    add_column :institutes, :latitude, :float
    add_column :institutes, :longitude, :float
  end
end
