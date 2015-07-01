class AddFirstNameAndLastNameAndIsWomanAndPhoneNumberAndBirthdateAndAddressAndZipcodeAndCity < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :is_woman, :boolean
    add_column :users, :phone_number, :boolean
    add_column :users, :birthdate, :string
    add_column :users, :address, :string
    add_column :users, :zipcode, :string
    add_column :users, :city, :string
  end
end
