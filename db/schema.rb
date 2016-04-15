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

ActiveRecord::Schema.define(version: 20160415022051) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "etsy_deets", force: :cascade do |t|
    t.string   "access_token"
    t.string   "access_secret"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "etsy_products", force: :cascade do |t|
    t.integer  "listing_id",           limit: 8
    t.integer  "category_id",          limit: 8
    t.string   "title"
    t.string   "description"
    t.string   "price"
    t.string   "currency_code"
    t.integer  "quantity"
    t.json     "tags"
    t.json     "category_path"
    t.json     "taxonomy_path"
    t.json     "materials"
    t.integer  "featured_rank"
    t.string   "url"
    t.integer  "views"
    t.integer  "num_favorers"
    t.integer  "shipping_template_id", limit: 8
    t.integer  "shipping_profile_id",  limit: 8
    t.json     "images"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "product_registrations", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "product_name"
    t.string   "product_number"
    t.string   "phone_number"
    t.string   "address_line_1"
    t.string   "address_line_2"
    t.string   "postal_code"
    t.string   "city"
    t.string   "province"
    t.string   "country"
    t.string   "email"
    t.string   "registration_number"
    t.datetime "date_of_manufacture"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

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
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
