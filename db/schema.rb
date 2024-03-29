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

ActiveRecord::Schema.define(version: 20190107222530) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "street_address"
    t.string "number"
    t.string "city"
    t.string "state"
    t.integer "zipcode"
    t.integer "address_type"
    t.integer "unit_type"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_addresses_on_user_id"
  end

  create_table "breakfasts", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.float "price"
    t.boolean "availability"
    t.integer "section"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "brunches", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.float "price"
    t.boolean "availability"
    t.integer "section"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dinners", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.float "price"
    t.boolean "availability"
    t.integer "section"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "happy_hours", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.float "price"
    t.boolean "availability"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "latenights", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.float "price"
    t.boolean "availability"
    t.integer "section"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lunches", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.float "price"
    t.boolean "availability"
    t.integer "section"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "phone_number"
    t.date "birth_day"
    t.boolean "text_club"
    t.boolean "email_club"
    t.boolean "terms"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin", default: false
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.datetime "activated_at"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["phone_number"], name: "index_users_on_phone_number", unique: true
  end

  add_foreign_key "addresses", "users"
end
