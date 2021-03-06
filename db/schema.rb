# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_08_24_010753) do

  create_table "books", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "title", null: false
    t.string "author", null: false
    t.integer "year", null: false
    t.string "goodreads_url"
    t.integer "copies_available", null: false
    t.integer "waitlist_length", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "copies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "edition_id", null: false
    t.bigint "user_id", null: false
    t.integer "status", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["edition_id"], name: "index_copies_on_edition_id"
    t.index ["user_id"], name: "index_copies_on_user_id"
  end

  create_table "editions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "book_id", null: false
    t.string "name", null: false
    t.decimal "width_inches", precision: 15, scale: 2, null: false
    t.decimal "length_inches", precision: 15, scale: 2, null: false
    t.decimal "height_inches", precision: 15, scale: 2, null: false
    t.decimal "weight_ounces", precision: 15, scale: 2, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["book_id"], name: "index_editions_on_book_id"
  end

  create_table "shipments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "copy_id", null: false
    t.bigint "waitlist_entry_id"
    t.bigint "from_user_id", null: false
    t.bigint "to_user_id", null: false
    t.integer "status", null: false
    t.string "easypost_id"
    t.string "label_url"
    t.string "easypost_tracker_id"
    t.string "easypost_tracking_url"
    t.string "stripe_payment_intent_id"
    t.datetime "received_at"
    t.boolean "sent_reminder_email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["copy_id"], name: "index_shipments_on_copy_id"
    t.index ["from_user_id"], name: "index_shipments_on_from_user_id"
    t.index ["to_user_id"], name: "index_shipments_on_to_user_id"
    t.index ["waitlist_entry_id"], name: "index_shipments_on_waitlist_entry_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "full_name", null: false
    t.string "street", null: false
    t.string "street2"
    t.string "city", null: false
    t.string "state", null: false
    t.string "postal_code", null: false
    t.boolean "admin", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "waitlist_entries", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "book_id", null: false
    t.datetime "notified_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["book_id"], name: "index_waitlist_entries_on_book_id"
    t.index ["user_id"], name: "index_waitlist_entries_on_user_id"
  end

  add_foreign_key "copies", "editions"
  add_foreign_key "copies", "users"
  add_foreign_key "shipments", "copies"
  add_foreign_key "shipments", "users", column: "from_user_id"
  add_foreign_key "shipments", "users", column: "to_user_id"
  add_foreign_key "shipments", "waitlist_entries"
  add_foreign_key "waitlist_entries", "books"
  add_foreign_key "waitlist_entries", "users"
end
