class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.references :user, index: true, foreign_key: true
      t.references :booking, index: true, foreign_key: true
      t.integer :rate
      t.text :comments

      t.timestamps null: false
    end
  end
end
