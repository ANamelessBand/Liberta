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

ActiveRecord::Schema.define(version: 2019_03_16_105743) do

  create_table "authors", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "authors_prints", id: false, force: :cascade do |t|
    t.integer "author_id", null: false
    t.integer "print_id", null: false
    t.index ["author_id"], name: "index_authors_prints_on_author_id"
    t.index ["print_id"], name: "index_authors_prints_on_print_id"
  end

  create_table "copies", force: :cascade do |t|
    t.integer "inventory_number", null: false
    t.integer "print_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["print_id"], name: "index_copies_on_print_id"
  end

  create_table "loans", force: :cascade do |t|
    t.datetime "time_loaned"
    t.datetime "time_supposed_return"
    t.datetime "time_returned"
    t.integer "copy_id"
    t.integer "user_id"
    t.index ["copy_id"], name: "index_loans_on_copy_id"
    t.index ["user_id"], name: "index_loans_on_user_id"
  end

  create_table "news", force: :cascade do |t|
    t.string "title", null: false
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.string "message", null: false
    t.boolean "read", default: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "prints", force: :cascade do |t|
    t.string "title", null: false
    t.string "language", null: false
    t.string "format"
    t.string "isbn"
    t.text "description"
    t.integer "pages"
    t.integer "publisher_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "cover_url"
    t.index ["publisher_id"], name: "index_prints_on_publisher_id"
  end

  create_table "prints_tags", id: false, force: :cascade do |t|
    t.integer "print_id", null: false
    t.integer "tag_id", null: false
    t.index ["print_id"], name: "index_prints_tags_on_print_id"
    t.index ["tag_id"], name: "index_prints_tags_on_tag_id"
  end

  create_table "publishers", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "recommendations", force: :cascade do |t|
    t.string "comment"
    t.float "rating", default: 0.0
    t.integer "user_id", null: false
    t.integer "print_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["print_id"], name: "index_recommendations_on_print_id"
    t.index ["user_id"], name: "index_recommendations_on_user_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.string "goodreads"
    t.boolean "admin", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.string "token"
    t.integer "expires_at"
    t.boolean "expires"
    t.string "refresh_token"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "wishlists", force: :cascade do |t|
    t.integer "user_id"
    t.integer "print_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["print_id"], name: "index_wishlists_on_print_id"
    t.index ["user_id"], name: "index_wishlists_on_user_id"
  end

end
