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

ActiveRecord::Schema.define(version: 2018_08_26_195152) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "movies", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "credit_card_number"
    t.date "expiration_date"
    t.integer "quantity"
    t.bigint "showtime_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["showtime_id"], name: "index_orders_on_showtime_id"
  end

  create_table "screens", force: :cascade do |t|
    t.integer "room_number"
    t.integer "capacity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "showtimes", force: :cascade do |t|
    t.datetime "time"
    t.integer "tickets_sold", default: 0
    t.decimal "price", precision: 5, scale: 2
    t.bigint "movie_id"
    t.bigint "screen_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["movie_id"], name: "index_showtimes_on_movie_id"
    t.index ["screen_id"], name: "index_showtimes_on_screen_id"
  end

  add_foreign_key "orders", "showtimes"
  add_foreign_key "showtimes", "movies"
  add_foreign_key "showtimes", "screens"
end
