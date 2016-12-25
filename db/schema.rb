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

ActiveRecord::Schema.define(version: 20161218234259) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "kinployees", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "availability"
    t.text     "cultural_backgrounds"
    t.string   "culture_match_preference"
    t.text     "languages"
    t.text     "location"
    t.string   "sex"
    t.text     "skills"
    t.index ["user_id"], name: "index_kinployees_on_user_id", using: :btree
  end

  create_table "kinployers", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_kinployers_on_user_id", using: :btree
  end

  create_table "kinployments", force: :cascade do |t|
    t.integer  "kinployee_id"
    t.integer  "kinployer_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "preferred_availability"
    t.text     "cultural_backgrounds"
    t.string   "culture_match_preference"
    t.text     "preferred_languages"
    t.text     "location"
    t.string   "preferred_sex"
    t.text     "preferred_skills"
    t.index ["kinployee_id"], name: "index_kinployments_on_kinployee_id", using: :btree
    t.index ["kinployer_id"], name: "index_kinployments_on_kinployer_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "password_digest"
    t.string   "remember_login_digest"
    t.integer  "role"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
  end

  add_foreign_key "kinployees", "users"
  add_foreign_key "kinployers", "users"
end
