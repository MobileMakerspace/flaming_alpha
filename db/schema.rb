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

ActiveRecord::Schema.define(version: 20170204203926) do

  create_table "double_entry_account_balances", force: :cascade do |t|
    t.string   "account",    limit: 31, null: false
    t.string   "scope",      limit: 23
    t.integer  "balance",               null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["account"], name: "index_account_balances_on_account"
    t.index ["scope", "account"], name: "index_account_balances_on_scope_and_account", unique: true
  end

  create_table "double_entry_line_aggregates", force: :cascade do |t|
    t.string   "function",   limit: 15, null: false
    t.string   "account",    limit: 31, null: false
    t.string   "code",       limit: 47
    t.string   "scope",      limit: 23
    t.integer  "year"
    t.integer  "month"
    t.integer  "week"
    t.integer  "day"
    t.integer  "hour"
    t.integer  "amount",                null: false
    t.string   "filter"
    t.string   "range_type", limit: 15, null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["function", "account", "code", "year", "month", "week", "day"], name: "line_aggregate_idx"
  end

  create_table "double_entry_line_checks", force: :cascade do |t|
    t.integer  "last_line_id", null: false
    t.boolean  "errors_found", null: false
    t.text     "log"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "double_entry_line_metadata", force: :cascade do |t|
    t.integer  "line_id",               null: false
    t.string   "key",        limit: 48, null: false
    t.string   "value",      limit: 64, null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["line_id", "key", "value"], name: "lines_meta_line_id_key_value_idx"
  end

  create_table "double_entry_lines", force: :cascade do |t|
    t.string   "account",         limit: 31, null: false
    t.string   "scope",           limit: 23
    t.string   "code",            limit: 47, null: false
    t.integer  "amount",                     null: false
    t.integer  "balance",                    null: false
    t.integer  "partner_id"
    t.string   "partner_account", limit: 31, null: false
    t.string   "partner_scope",   limit: 23
    t.integer  "detail_id"
    t.string   "detail_type"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["account", "code", "created_at"], name: "lines_account_code_created_at_idx"
    t.index ["account", "created_at"], name: "lines_account_created_at_idx"
    t.index ["scope", "account", "created_at"], name: "lines_scope_account_created_at_idx"
    t.index ["scope", "account", "id"], name: "lines_scope_account_id_idx"
  end

  create_table "keys", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "identifier"
    t.date     "assigned"
    t.date     "returned"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_keys_on_user_id"
  end

  create_table "payment_notifications", force: :cascade do |t|
    t.text     "notification_params"
    t.string   "status"
    t.string   "transaction_id"
    t.datetime "purchased_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.boolean  "applied",             default: false, null: false
    t.integer  "user_id"
    t.index ["user_id"], name: "index_payment_notifications_on_user_id"
  end

  create_table "plans", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.boolean  "active"
    t.boolean  "approval_needed"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "price_cents",     default: 0,     null: false
    t.string   "price_currency",  default: "USD", null: false
  end

  create_table "settings", force: :cascade do |t|
    t.string   "var",                   null: false
    t.text     "value"
    t.integer  "thing_id"
    t.string   "thing_type", limit: 30
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["thing_type", "thing_id", "var"], name: "index_settings_on_thing_type_and_thing_id_and_var", unique: true
  end

  create_table "subscriptions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "plan_id"
    t.date     "start"
    t.date     "stop"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.date     "last_billed"
    t.index ["plan_id"], name: "index_subscriptions_on_plan_id"
    t.index ["user_id"], name: "index_subscriptions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "role"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.string   "invited_by_type"
    t.integer  "invited_by_id"
    t.integer  "invitations_count",      default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invitations_count"], name: "index_users_on_invitations_count"
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
