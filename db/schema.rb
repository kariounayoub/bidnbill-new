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

ActiveRecord::Schema.define(version: 2019_05_03_153346) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "account_categories", force: :cascade do |t|
    t.bigint "account_id"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_account_categories_on_account_id"
    t.index ["category_id"], name: "index_account_categories_on_category_id"
  end

  create_table "accounts", force: :cascade do |t|
    t.string "company"
    t.boolean "is_deleted"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bids", force: :cascade do |t|
    t.bigint "bill_id"
    t.bigint "user_id"
    t.string "status"
    t.text "content"
    t.float "price"
    t.boolean "needs_editing", default: false
    t.boolean "provider_notification_sent", default: false
    t.boolean "is_deleted"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bill_id"], name: "index_bids_on_bill_id"
    t.index ["user_id"], name: "index_bids_on_user_id"
  end

  create_table "bills", force: :cascade do |t|
    t.bigint "user_id"
    t.string "current_provider"
    t.string "address"
    t.string "payment_frequency"
    t.float "price"
    t.string "photo"
    t.bigint "category_id"
    t.float "latitude"
    t.float "longitude"
    t.integer "consumption"
    t.string "city"
    t.string "zip_code"
    t.boolean "calculated_consumption", default: false
    t.string "type_home"
    t.integer "nb_people"
    t.integer "surface"
    t.string "hot_water"
    t.string "heating"
    t.boolean "fridge"
    t.boolean "freezer"
    t.boolean "oven"
    t.boolean "dishwasher"
    t.boolean "washer"
    t.boolean "dryer"
    t.boolean "is_deleted"
    t.boolean "is_open"
    t.boolean "send_update_email"
    t.integer "days_without_mail", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_bills_on_category_id"
    t.index ["user_id"], name: "index_bills_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.boolean "is_deleted"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "user_type"
    t.string "company"
    t.string "phone_number"
    t.string "photo"
    t.boolean "admin"
    t.integer "days_since_last_provider_email", default: 1
    t.bigint "account_id"
    t.index ["account_id"], name: "index_users_on_account_id"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "account_categories", "accounts"
  add_foreign_key "account_categories", "categories"
  add_foreign_key "bids", "bills"
  add_foreign_key "bids", "users"
  add_foreign_key "bills", "categories"
  add_foreign_key "bills", "users"
end
