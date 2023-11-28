# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2023_11_19_004740) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "account_login_change_keys", id: :serial, force: :cascade do |t|
    t.string "key", null: false
    t.string "login", null: false
    t.datetime "deadline", null: false
  end

  create_table "account_password_reset_keys", id: :serial, force: :cascade do |t|
    t.string "key", null: false
    t.datetime "deadline", null: false
    t.datetime "email_last_sent", default: -> { "CURRENT_TIMESTAMP" }, null: false
  end

  create_table "account_remember_keys", id: :serial, force: :cascade do |t|
    t.string "key", null: false
    t.datetime "deadline", null: false
  end

  create_table "account_verification_keys", id: :serial, force: :cascade do |t|
    t.string "key", null: false
    t.datetime "requested_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "email_last_sent", default: -> { "CURRENT_TIMESTAMP" }, null: false
  end

  create_table "accounts", force: :cascade do |t|
    t.integer "status", default: 1, null: false
    t.string "email", null: false
    t.string "password_hash"
    t.index ["email"], name: "index_accounts_on_email", unique: true, where: "(status = ANY (ARRAY[1, 2]))"
  end

  create_table "area_robots", force: :cascade do |t|
    t.bigint "robot_id", null: false
    t.bigint "area_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["area_id"], name: "index_area_robots_on_area_id"
    t.index ["robot_id"], name: "index_area_robots_on_robot_id"
  end

  create_table "areas", force: :cascade do |t|
    t.bigint "plan_id", null: false
    t.string "area_id", null: false
    t.geometry "position", limit: {:srid=>0, :type=>"geometry"}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plan_id"], name: "index_areas_on_plan_id"
    t.index ["position"], name: "index_areas_on_position"
  end

  create_table "lines", force: :cascade do |t|
    t.integer "from_node_id", null: false
    t.integer "to_node_id", null: false
    t.float "distance", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["from_node_id"], name: "index_lines_on_from_node_id"
    t.index ["to_node_id"], name: "index_lines_on_to_node_id"
  end

  create_table "nodes", force: :cascade do |t|
    t.bigint "plan_id", null: false
    t.geometry "position", limit: {:srid=>0, :type=>"geometry"}, null: false
    t.integer "time_required", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plan_id"], name: "index_nodes_on_plan_id"
    t.index ["position"], name: "index_nodes_on_position"
  end

  create_table "plans", force: :cascade do |t|
    t.datetime "planned_at", null: false
    t.text "planning_info", null: false
    t.string "plan_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "robots", force: :cascade do |t|
    t.datetime "start_time", null: false
    t.string "robot_id", null: false
    t.geometry "position", limit: {:srid=>0, :type=>"geometry"}, null: false
    t.bigint "plan_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plan_id"], name: "index_robots_on_plan_id"
    t.index ["position"], name: "index_robots_on_position"
  end

  create_table "ways", force: :cascade do |t|
    t.bigint "plan_id", null: false
    t.bigint "robot_id", null: false
    t.bigint "node_id", null: false
    t.datetime "arrival_at", null: false
    t.datetime "leave_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["node_id"], name: "index_ways_on_node_id"
    t.index ["plan_id"], name: "index_ways_on_plan_id"
    t.index ["robot_id"], name: "index_ways_on_robot_id"
  end

  add_foreign_key "account_login_change_keys", "accounts", column: "id"
  add_foreign_key "account_password_reset_keys", "accounts", column: "id"
  add_foreign_key "account_remember_keys", "accounts", column: "id"
  add_foreign_key "account_verification_keys", "accounts", column: "id"
  add_foreign_key "area_robots", "areas"
  add_foreign_key "area_robots", "robots"
  add_foreign_key "areas", "plans"
  add_foreign_key "nodes", "plans"
  add_foreign_key "robots", "plans"
  add_foreign_key "ways", "nodes"
  add_foreign_key "ways", "plans"
  add_foreign_key "ways", "robots"
end
