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

ActiveRecord::Schema.define(version: 20180430222341) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace",     limit: 255
    t.text     "body",          limit: 65535
    t.string   "resource_id",   limit: 255,   null: false
    t.string   "resource_type", limit: 255,   null: false
    t.integer  "author_id",     limit: 4
    t.string   "author_type",   limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "activity_loggers", force: :cascade do |t|
    t.string   "contact",       limit: 255
    t.string   "activity",      limit: 255
    t.string   "activity_type", limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "brands_we_services", force: :cascade do |t|
    t.string   "title",         limit: 255
    t.integer  "repairshop_id", limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "brands_we_services", ["repairshop_id"], name: "index_brands_we_services_on_repairshop_id", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string "name", limit: 255
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",    limit: 255, null: false
    t.string   "data_content_type", limit: 255
    t.integer  "data_file_size",    limit: 4
    t.string   "type",              limit: 30
    t.integer  "width",             limit: 4
    t.integer  "height",            limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "ckeditor_assets", ["type"], name: "index_ckeditor_assets_on_type", using: :btree

  create_table "coupons", force: :cascade do |t|
    t.string   "image",         limit: 255
    t.string   "title",         limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "repairshop_id", limit: 4
  end

  add_index "coupons", ["repairshop_id"], name: "fk_rails_eea661cd02", using: :btree

  create_table "inquiries", force: :cascade do |t|
    t.string   "from_email", limit: 255
    t.string   "to_email",   limit: 255
    t.string   "first_name", limit: 255
    t.string   "last_name",  limit: 255
    t.string   "phone",      limit: 255
    t.string   "subject",    limit: 255
    t.string   "comment",    limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "status",     limit: 255, default: "FRESH"
    t.boolean  "senttoall",              default: false
    t.string   "referredby", limit: 255, default: "WACBAC"
    t.string   "offer",      limit: 255, default: "Listed Price"
  end

  create_table "installs", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "installs", ["email"], name: "index_installs_on_email", unique: true, using: :btree
  add_index "installs", ["reset_password_token"], name: "index_installs_on_reset_password_token", unique: true, using: :btree

  create_table "listings", force: :cascade do |t|
    t.string   "title",                  limit: 255
    t.text     "description",            limit: 65535
    t.string   "city",                   limit: 255,   default: "NOT LISTED"
    t.string   "state",                  limit: 255,   default: "NOT LISTED"
    t.string   "zipcode",                limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id",            limit: 4
    t.integer  "subcategory_id",         limit: 4
    t.float    "latitude",               limit: 24
    t.float    "longitude",              limit: 24
    t.integer  "user_id",                limit: 4
    t.string   "image",                  limit: 255
    t.integer  "year",                   limit: 4,     default: 0
    t.integer  "miles",                  limit: 4
    t.string   "transmission",           limit: 255,   default: "AUTOMATIC"
    t.string   "color",                  limit: 255
    t.string   "cylinder",               limit: 255,   default: "NOT LISTED"
    t.string   "fuel",                   limit: 255,   default: "GASOLINE"
    t.string   "drive",                  limit: 255,   default: "2WD"
    t.string   "address",                limit: 255
    t.boolean  "wholesale",                            default: false
    t.integer  "price",                  limit: 4,     default: 0
    t.string   "newused",                limit: 255,   default: "U"
    t.string   "vin",                    limit: 255
    t.string   "stocknumber",            limit: 255
    t.string   "model",                  limit: 255
    t.string   "trim",                   limit: 255
    t.string   "enginedescription",      limit: 255
    t.string   "interiorcolor",          limit: 255
    t.text     "options",                limit: 65535
    t.string   "imagefront",             limit: 255
    t.string   "imageback",              limit: 255
    t.string   "imageleft",              limit: 255
    t.string   "imageright",             limit: 255
    t.string   "frontinterior",          limit: 255
    t.string   "rearinterior",           limit: 255
    t.string   "bodytype",               limit: 255,   default: "NOT LISTED"
    t.string   "make",                   limit: 255
    t.boolean  "approved",                             default: false
    t.datetime "expiration_date",                      default: '2218-01-03 01:44:43'
    t.boolean  "external_url",                         default: false
    t.string   "external_image",         limit: 255
    t.string   "external_imagefront",    limit: 255
    t.string   "external_imageback",     limit: 255
    t.string   "external_imageleft",     limit: 255
    t.string   "external_imageright",    limit: 255
    t.string   "external_frontinterior", limit: 255
    t.string   "external_rearinterior",  limit: 255
  end

  add_index "listings", ["user_id"], name: "index_listings_on_user_id", using: :btree
  add_index "listings", ["vin", "title"], name: "index_listings_on_vin_and_title", unique: true, using: :btree

  create_table "new_dealer_contacts", force: :cascade do |t|
    t.string   "dealershipname", limit: 255
    t.string   "fullname",       limit: 255
    t.string   "email",          limit: 255
    t.string   "phone",          limit: 255
    t.string   "zip",            limit: 255
    t.string   "address",        limit: 255
    t.string   "city",           limit: 255
    t.string   "state",          limit: 255
    t.string   "website",        limit: 255
    t.string   "inventoryhost",  limit: 255
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "notes", force: :cascade do |t|
    t.integer  "comment_by", limit: 4
    t.text     "note",       limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "inquiry_id", limit: 4
  end

  add_index "notes", ["inquiry_id"], name: "index_notes_on_inquiry_id", using: :btree

  create_table "repairshops", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "description", limit: 65535
    t.string   "city",        limit: 255,   default: "NOT LISTED"
    t.string   "state",       limit: 255,   default: "NOT LISTED"
    t.string   "zipcode",     limit: 255
    t.string   "phone",       limit: 255
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.float    "latitude",    limit: 24
    t.float    "longitude",   limit: 24
    t.integer  "user_id",     limit: 4
    t.string   "image",       limit: 255
    t.integer  "category_id", limit: 4
    t.boolean  "approved",                  default: false
  end

  add_index "repairshops", ["category_id"], name: "index_repairshops_on_category_id", using: :btree
  add_index "repairshops", ["user_id"], name: "index_repairshops_on_user_id", using: :btree

  create_table "reviews", force: :cascade do |t|
    t.string   "comment",    limit: 255
    t.integer  "rating",     limit: 4
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "user_id",    limit: 4
    t.integer  "owner_id",   limit: 4
    t.boolean  "approved",               default: false
    t.boolean  "appeal",                 default: false
  end

  add_index "reviews", ["user_id"], name: "fk_rails_74a66bd6c5", using: :btree

  create_table "specializations", force: :cascade do |t|
    t.string   "title",         limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "repairshop_id", limit: 4
  end

  add_index "specializations", ["repairshop_id"], name: "index_specializations_on_repairshop_id", using: :btree

  create_table "subcategories", force: :cascade do |t|
    t.string  "name",        limit: 255
    t.integer "category_id", limit: 4
  end

  create_table "timetables", force: :cascade do |t|
    t.string   "day",        limit: 255
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "user_id",    limit: 4
  end

  add_index "timetables", ["user_id"], name: "index_timetables_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",           null: false
    t.string   "encrypted_password",     limit: 255, default: "",           null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,            null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
    t.integer  "role",                   limit: 4
    t.string   "website",                limit: 255
    t.string   "zipcode",                limit: 255
    t.string   "city",                   limit: 255, default: "NOT LISTED"
    t.string   "state",                  limit: 255, default: "NOT LISTED"
    t.string   "street_address",         limit: 255
    t.float    "latitude",               limit: 24
    t.float    "longitude",              limit: 24
    t.string   "phone_number",           limit: 255
    t.string   "name",                   limit: 255, default: "No Name"
    t.string   "backgroundimage",        limit: 255
    t.string   "logoimage",              limit: 255
    t.string   "websiteheader",          limit: 255
    t.string   "websitesubheader",       limit: 255
    t.string   "websitedescription",     limit: 255
    t.boolean  "leads2dealscustomer",                default: false
    t.string   "slug",                   limit: 255
    t.boolean  "verified",                           default: false
    t.boolean  "tdcfinance",                         default: false
    t.string   "textcolor",              limit: 255, default: "white"
    t.string   "leademail1",             limit: 255
    t.string   "leademail2",             limit: 255
    t.string   "textbackgroundcolor",    limit: 255, default: "0,0,0"
    t.boolean  "bhphcustomer",                       default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["slug"], name: "index_users_on_slug", using: :btree

  add_foreign_key "brands_we_services", "repairshops"
  add_foreign_key "coupons", "repairshops"
  add_foreign_key "notes", "inquiries", on_delete: :cascade
  add_foreign_key "reviews", "users"
  add_foreign_key "specializations", "repairshops"
  add_foreign_key "timetables", "users", on_delete: :cascade
end
