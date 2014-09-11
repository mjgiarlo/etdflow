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

ActiveRecord::Schema.define(version: 20140911171644) do

  create_table "authors", force: true do |t|
    t.string   "access_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "middle_name"
    t.string   "alternate_email_address"
    t.string   "psu_email_address"
    t.string   "phone_number"
    t.string   "address_1"
    t.string   "address_2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.boolean  "is_alternate_email_public"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bookmarks", force: true do |t|
    t.integer  "user_id",       null: false
    t.string   "user_type"
    t.string   "document_id"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "document_type"
  end

  add_index "bookmarks", ["user_id"], name: "index_bookmarks_on_user_id", using: :btree

  create_table "committee_members", force: true do |t|
    t.integer  "submission_id"
    t.string   "role"
    t.string   "name"
    t.string   "email"
    t.boolean  "is_advisor"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "degrees", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "degree_type"
    t.boolean  "is_active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "format_review_files", force: true do |t|
    t.integer  "submission_id"
    t.text     "filename"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "programs", force: true do |t|
    t.string   "name"
    t.boolean  "is_active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "searches", force: true do |t|
    t.text     "query_params"
    t.integer  "user_id"
    t.string   "user_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "searches", ["user_id"], name: "index_searches_on_user_id", using: :btree

  create_table "submissions", force: true do |t|
    t.integer  "author_id"
    t.integer  "program_id"
    t.integer  "degree_id"
    t.string   "semester"
    t.integer  "year"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
    t.string   "title"
    t.text     "format_review_notes"
    t.text     "final_submission_notes"
    t.datetime "defended_at"
    t.text     "abstract"
    t.text     "keywords"
    t.string   "access_level"
    t.boolean  "has_agreed_to_terms"
  end

  create_table "users", force: true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
