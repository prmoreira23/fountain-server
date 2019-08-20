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

ActiveRecord::Schema.define(version: 2019_08_20_032039) do

  create_table "applications", force: :cascade do |t|
    t.integer "user_id"
    t.integer "job_opening_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_opening_id"], name: "index_applications_on_job_opening_id"
    t.index ["user_id"], name: "index_applications_on_user_id"
  end

  create_table "job_openings", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "employer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employer_id"], name: "index_job_openings_on_employer_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.integer "role"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
