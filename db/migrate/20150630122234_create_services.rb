class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.references :institute, index: true, foreign_key: true
      t.string :title
      t.text :description
      t.integer :price
      t.integer :duration
      t.string :category

      t.timestamps null: false
    end
  end
end
