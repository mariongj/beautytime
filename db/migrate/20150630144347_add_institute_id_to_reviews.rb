class AddInstituteIdToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :institute_id, :integer
  end
end
