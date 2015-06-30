class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.references :user, index: true, foreign_key: true
      t.references :service, index: true, foreign_key: true
      t.datetime :start_datetime
      t.datetime :end_datetime
      t.boolean :canceled
      t.boolean :manual
      t.string :manual_email

      t.timestamps null: false
    end
  end
end
