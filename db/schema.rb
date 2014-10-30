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

ActiveRecord::Schema.define(version: 20141029180726) do

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
    t.integer  "sign_in_count",             default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  create_table "committee_members", force: true do |t|
    t.integer  "submission_id"
    t.string   "role"
    t.string   "name"
    t.string   "email"
    t.boolean  "is_advisor"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "committee_members", ["submission_id"], name: "committee_members_submission_id_fk", using: :btree

  create_table "degrees", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "degree_type"
    t.boolean  "is_active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "final_submission_files", force: true do |t|
    t.integer  "submission_id"
    t.text     "asset"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "content_type"
  end

  add_index "final_submission_files", ["submission_id"], name: "final_submission_files_submission_id_fk", using: :btree

  create_table "format_review_files", force: true do |t|
    t.integer  "submission_id"
    t.text     "asset"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "format_review_files", ["submission_id"], name: "format_review_files_submission_id_fk", using: :btree

  create_table "programs", force: true do |t|
    t.string   "name"
    t.boolean  "is_active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
    t.datetime "committee_provided_at"
    t.datetime "format_review_files_uploaded_at"
    t.datetime "format_review_rejected_at"
    t.datetime "format_review_approved_at"
    t.datetime "final_submission_files_uploaded_at"
    t.datetime "final_submission_rejected_at"
    t.datetime "final_submission_approved_at"
    t.datetime "released_for_publication_at"
    t.string   "fedora_id"
  end

  add_index "submissions", ["author_id"], name: "submissions_author_id_fk", using: :btree
  add_index "submissions", ["degree_id"], name: "submissions_degree_id_fk", using: :btree
  add_index "submissions", ["program_id"], name: "submissions_program_id_fk", using: :btree

  add_foreign_key "committee_members", "submissions", name: "committee_members_submission_id_fk", dependent: :delete

  add_foreign_key "final_submission_files", "submissions", name: "final_submission_files_submission_id_fk", dependent: :delete

  add_foreign_key "format_review_files", "submissions", name: "format_review_files_submission_id_fk", dependent: :delete

  add_foreign_key "submissions", "authors", name: "submissions_author_id_fk", dependent: :delete
  add_foreign_key "submissions", "degrees", name: "submissions_degree_id_fk"
  add_foreign_key "submissions", "programs", name: "submissions_program_id_fk"

end
