class CreateInstitutes < ActiveRecord::Migration
  def change
    create_table :institutes do |t|
      t.string :name
      t.text :description
      t.string :address
      t.references :user, index: true, foreign_key: true
      t.boolean :validated
      t.string :zipcode
      t.string :city

      t.timestamps null: false
    end
  end
end
