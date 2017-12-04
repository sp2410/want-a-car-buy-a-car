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

ActiveRecord::Schema.define(version: 20171203045809) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true

  create_table "brands_we_services", force: :cascade do |t|
    t.string   "title"
    t.integer  "repairshop_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "brands_we_services", ["repairshop_id"], name: "index_brands_we_services_on_repairshop_id"

  create_table "categories", force: :cascade do |t|
    t.string "name"
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "ckeditor_assets", ["type"], name: "index_ckeditor_assets_on_type"

  create_table "coupons", force: :cascade do |t|
    t.string   "image"
    t.string   "title"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "repairshop_id"
  end

  create_table "inquiries", force: :cascade do |t|
    t.string   "from_email"
    t.string   "to_email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone"
    t.string   "subject"
    t.string   "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "installs", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "installs", ["email"], name: "index_installs_on_email", unique: true
  add_index "installs", ["reset_password_token"], name: "index_installs_on_reset_password_token", unique: true

  create_table "listings", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id"
    t.integer  "subcategory_id"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "user_id"
    t.string   "image"
    t.integer  "year"
    t.integer  "miles"
    t.string   "transmission"
    t.string   "color"
    t.string   "cylinder"
    t.string   "fuel"
    t.string   "drive"
    t.string   "address"
    t.boolean  "wholesale",         default: false
    t.integer  "price",             default: 0
    t.string   "newused"
    t.string   "vin"
    t.string   "stocknumber"
    t.string   "model"
    t.string   "trim"
    t.string   "enginedescription"
    t.string   "interiorcolor"
    t.string   "options"
    t.string   "imagefront"
    t.string   "imageback"
    t.string   "imageleft"
    t.string   "imageright"
    t.string   "frontinterior"
    t.string   "rearinterior"
    t.string   "bodytype"
    t.string   "make"
  end

  add_index "listings", ["user_id"], name: "index_listings_on_user_id"

  create_table "repairshops", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.string   "phone"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "user_id"
    t.string   "image"
    t.integer  "category_id"
  end

  add_index "repairshops", ["category_id"], name: "index_repairshops_on_category_id"
  add_index "repairshops", ["user_id"], name: "index_repairshops_on_user_id"

  create_table "reviews", force: :cascade do |t|
    t.string   "comment"
    t.integer  "rating"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "user_id"
    t.integer  "owner_id"
    t.boolean  "approved",   default: false
  end

  create_table "specializations", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "repairshop_id"
  end

  add_index "specializations", ["repairshop_id"], name: "index_specializations_on_repairshop_id"

  create_table "subcategories", force: :cascade do |t|
    t.string  "name"
    t.integer "category_id"
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
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "role"
    t.string   "website"
    t.string   "zipcode"
    t.string   "city"
    t.string   "state"
    t.string   "street_address"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "phone_number"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
