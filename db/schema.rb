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

ActiveRecord::Schema.define(version: 20150622123657) do

  create_table "cmn_lexical_entries", force: :cascade do |t|
    t.integer  "lexicon_id"
    t.integer  "lexical_entry_type"
    t.integer  "part_of_speech"
    t.string   "simplified"
    t.string   "traditional"
    t.string   "pinyin"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "cmn_lexical_entries", ["lexicon_id"], name: "index_cmn_lexical_entries_on_lexicon_id"

  create_table "cmn_senses", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lexical_entry_selections", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "lexicon_id"
    t.text     "lexical_entry_ids"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "lexical_entry_selections", ["lexicon_id"], name: "index_lexical_entry_selections_on_lexicon_id"
  add_index "lexical_entry_selections", ["user_id"], name: "index_lexical_entry_selections_on_user_id"

  create_table "lexical_resources", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "lexical_resources", ["user_id"], name: "index_lexical_resources_on_user_id"

  create_table "lexicons", force: :cascade do |t|
    t.string   "name"
    t.integer  "lexical_resource_id"
    t.string   "type"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "lexicons", ["lexical_resource_id"], name: "index_lexicons_on_lexical_resource_id"

  create_table "senses", force: :cascade do |t|
    t.integer  "lexical_entry_id"
    t.string   "description"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "senses", ["lexical_entry_id"], name: "index_senses_on_lexical_entry_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_hash"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

end
