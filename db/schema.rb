# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150709122019) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bookings", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "service_id"
    t.datetime "start_datetime"
    t.datetime "end_datetime"
    t.boolean  "canceled"
    t.boolean  "manual"
    t.string   "manual_email"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "bookings", ["service_id"], name: "index_bookings_on_service_id", using: :btree
  add_index "bookings", ["user_id"], name: "index_bookings_on_user_id", using: :btree

  create_table "institutes", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "address"
    t.integer  "user_id"
    t.boolean  "validated"
    t.string   "zipcode"
    t.string   "city"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "picture1_file_name"
    t.string   "picture1_content_type"
    t.integer  "picture1_file_size"
    t.datetime "picture1_updated_at"
    t.string   "picture2_file_name"
    t.string   "picture2_content_type"
    t.integer  "picture2_file_size"
    t.datetime "picture2_updated_at"
    t.string   "picture3_file_name"
    t.string   "picture3_content_type"
    t.integer  "picture3_file_size"
    t.datetime "picture3_updated_at"
    t.float    "latitude"
    t.float    "longitude"
  end

  add_index "institutes", ["user_id"], name: "index_institutes_on_user_id", using: :btree

  create_table "reviews", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "booking_id"
    t.integer  "rate"
    t.text     "comments"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "institute_id"
  end

  add_index "reviews", ["booking_id"], name: "index_reviews_on_booking_id", using: :btree
  add_index "reviews", ["user_id"], name: "index_reviews_on_user_id", using: :btree

  create_table "services", force: :cascade do |t|
    t.integer  "institute_id"
    t.string   "title"
    t.text     "description"
    t.integer  "price"
    t.integer  "duration"
    t.string   "category"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "services", ["institute_id"], name: "index_services_on_institute_id", using: :btree

  create_table "timetables", force: :cascade do |t|
    t.integer  "service_id"
    t.time     "monday_start_time"
    t.time     "monday_end_time"
    t.time     "tuesday_start_time"
    t.time     "tuesday_end_time"
    t.time     "wednesday_start_time"
    t.time     "wednesday_end_time"
    t.time     "thursday_start_time"
    t.time     "thursday_end_time"
    t.time     "friday_start_time"
    t.time     "friday_end_time"
    t.time     "saturday_start_time"
    t.time     "saturday_end_time"
    t.time     "sunday_start_time"
    t.time     "sunday_end_time"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "timetables", ["service_id"], name: "index_timetables_on_service_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "is_woman"
    t.string   "phone_number"
    t.string   "birthdate"
    t.string   "address"
    t.string   "zipcode"
    t.string   "city"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.string   "provider"
    t.string   "uid"
    t.string   "avatar"
    t.string   "name"
    t.string   "token"
    t.datetime "token_expiry"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "bookings", "services"
  add_foreign_key "bookings", "users"
  add_foreign_key "institutes", "users"
  add_foreign_key "reviews", "bookings"
  add_foreign_key "reviews", "users"
  add_foreign_key "services", "institutes"
  add_foreign_key "timetables", "services"
end
