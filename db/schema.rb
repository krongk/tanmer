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

ActiveRecord::Schema.define(version: 20140829073457) do

  create_table "books", force: true do |t|
    t.integer  "member_id",                  null: false
    t.integer  "page_id",                    null: false
    t.string   "message"
    t.string   "is_processed", default: "n", null: false
    t.string   "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "books", ["is_processed"], name: "index_books_on_is_processed", using: :btree
  add_index "books", ["member_id"], name: "idx__member", using: :btree
  add_index "books", ["page_id"], name: "index_books_on_page_id", using: :btree

  create_table "ckeditor_assets", force: true do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "follows", force: true do |t|
    t.string   "follower_type"
    t.integer  "follower_id"
    t.string   "followable_type"
    t.integer  "followable_id"
    t.datetime "created_at"
  end

  add_index "follows", ["followable_id", "followable_type"], name: "fk_followables", using: :btree
  add_index "follows", ["follower_id", "follower_type"], name: "fk_follows", using: :btree

  create_table "ip_addresses", force: true do |t|
    t.integer  "page_id"
    t.string   "ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ip_addresses", ["page_id", "ip"], name: "index_ip_addresses_on_page_id_and_ip", using: :btree

  create_table "keystores", force: true do |t|
    t.string   "key",        null: false
    t.string   "value",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "keystores", ["key"], name: "index_keystores_on_user_id_and_key", unique: true, using: :btree

  create_table "likes", force: true do |t|
    t.string   "liker_type"
    t.integer  "liker_id"
    t.string   "likeable_type"
    t.integer  "likeable_id"
    t.datetime "created_at"
  end

  add_index "likes", ["likeable_id", "likeable_type"], name: "fk_likeables", using: :btree
  add_index "likes", ["liker_id", "liker_type"], name: "fk_likes", using: :btree

  create_table "members", force: true do |t|
    t.integer  "user_id",                             null: false
    t.string   "email",                  default: "", null: false
    t.string   "phone",                  default: "", null: false
    t.string   "name"
    t.string   "address"
    t.string   "message"
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

  add_index "members", ["email"], name: "index_members_on_email", unique: true, using: :btree
  add_index "members", ["reset_password_token"], name: "index_members_on_reset_password_token", unique: true, using: :btree
  add_index "members", ["user_id"], name: "idx__user_id", using: :btree

  create_table "mentions", force: true do |t|
    t.string   "mentioner_type"
    t.integer  "mentioner_id"
    t.string   "mentionable_type"
    t.integer  "mentionable_id"
    t.datetime "created_at"
  end

  add_index "mentions", ["mentionable_id", "mentionable_type"], name: "fk_mentionables", using: :btree
  add_index "mentions", ["mentioner_id", "mentioner_type"], name: "fk_mentions", using: :btree

  create_table "page_contents", force: true do |t|
    t.integer "page_id"
    t.text    "content"
  end

  add_index "page_contents", ["page_id"], name: "index_page_contents_on_page_id", using: :btree

  create_table "page_rates", force: true do |t|
    t.integer  "page_id"
    t.integer  "member_id"
    t.integer  "pv_count",   default: 0
    t.integer  "ip_count",   default: 0
    t.string   "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "page_rates", ["member_id"], name: "index_page_rates_on_member_id", using: :btree
  add_index "page_rates", ["page_id"], name: "index_page_rates_on_page_id", using: :btree

  create_table "pages", force: true do |t|
    t.integer  "user_id",                                                               null: false
    t.string   "typo",         limit: 32,                           default: "default", null: false
    t.string   "title",        limit: 128,                                              null: false
    t.string   "keywords"
    t.string   "description",  limit: 512
    t.string   "qrcode",       limit: 128
    t.string   "short_title",  limit: 32
    t.string   "properties",   limit: 64
    t.string   "extend_url",   limit: 128
    t.integer  "amount"
    t.decimal  "price",                    precision: 10, scale: 0
    t.integer  "pv_count",                                          default: 0
    t.integer  "fav_count",                                         default: 0
    t.integer  "ip_count",                                          default: 0
    t.string   "is_processed", limit: 50,                           default: "n",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pages", ["is_processed"], name: "index_pages_on_is_processed", using: :btree
  add_index "pages", ["title"], name: "index_pages_on_title", using: :btree
  add_index "pages", ["user_id", "short_title"], name: "index_pages_on_user_id_and_short_title", unique: true, using: :btree
  add_index "pages", ["user_id"], name: "index_pages_on_user_id", using: :btree

  create_table "payment_notifies", force: true do |t|
    t.integer  "payment_id"
    t.boolean  "verify"
    t.string   "payment_number"
    t.decimal  "payment_count",  precision: 8, scale: 2
    t.string   "state"
    t.string   "cate"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "payment_notifies", ["payment_id"], name: "index_payment_notifies_on_payment_id", using: :btree

  create_table "payments", force: true do |t|
    t.integer  "user_id"
    t.decimal  "price",        precision: 8, scale: 2
    t.string   "state"
    t.datetime "pending_at"
    t.datetime "completed_at"
    t.datetime "canceled_at"
    t.datetime "paid_at"
    t.string   "trade_no"
    t.string   "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "payments", ["user_id"], name: "index_payments_on_user_id", using: :btree

  create_table "relationships", force: true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "relationships", ["followed_id"], name: "index_relationships_on_followed_id", using: :btree
  add_index "relationships", ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true, using: :btree
  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id", using: :btree

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: true do |t|
    t.string "name"
  end

  create_table "users", force: true do |t|
    t.string   "typo",                   limit: 50
    t.string   "name"
    t.string   "email",                                                                   null: false
    t.string   "encrypted_password",                                                      null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                                               default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description",            limit: 1024
    t.decimal  "total_price",                         precision: 8, scale: 2
    t.string   "provider"
    t.string   "uid"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

end
