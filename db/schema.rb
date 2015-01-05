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

ActiveRecord::Schema.define(version: 20150105095759) do

  create_table "invoices", force: true do |t|
    t.decimal  "value"
    t.integer  "operator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "done",           default: false
    t.string   "title"
    t.date     "due_date"
    t.date     "done_date"
    t.boolean  "valid_due_date"
  end

  add_index "invoices", ["operator_id"], name: "index_invoices_on_operator_id"

  create_table "operators", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "days_between_invoices"
  end

end
