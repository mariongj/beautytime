class RenamePicturefromUsers < ActiveRecord::Migration
  def change
    rename_column :users, :picture, :avatar
  end
end
