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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130322134055) do

  create_table "clients", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "authentication_token"
    t.string   "name"
    t.text     "description"
    t.string   "avatar_file_name"
    t.integer  "avatar_file_size"
    t.string   "avatar_content_type"
    t.integer  "product_id"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "clients", ["confirmation_token"], :name => "index_clients_on_confirmation_token", :unique => true
  add_index "clients", ["email"], :name => "index_clients_on_email", :unique => true
  add_index "clients", ["reset_password_token"], :name => "index_clients_on_reset_password_token", :unique => true

  create_table "images", :force => true do |t|
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.integer  "product_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "products", :force => true do |t|
    t.text     "product_internal_name"
    t.text     "product_external_name"
    t.text     "product_description"
    t.string   "sku"
    t.integer  "unit_price"
    t.boolean  "in_stock"
    t.boolean  "allow_express_shopping"
    t.integer  "express_shipping_price"
    t.string   "one_eight_hundred_number"
    t.text     "voice_generated_message"
    t.text     "sms"
    t.string   "forward_call_number"
    t.integer  "client_id"
    t.integer  "user_id"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
    t.integer  "shipping_and_handling"
    t.integer  "product_cost"
  end

  create_table "products_recommenders", :force => true do |t|
    t.integer  "client_id"
    t.integer  "product_id"
    t.integer  "recommender_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "credit_card_name"
    t.string   "credit_card_number"
    t.string   "credit_card_cvv"
    t.string   "credit_card_expiration"
    t.string   "stripe_credit_card_token"
    t.string   "shipping_name"
    t.string   "shipping_address"
    t.string   "shipping_country"
    t.string   "shipping_zip"
    t.boolean  "is_billing_info"
    t.string   "billing_name"
    t.string   "billing_address"
    t.string   "billing_country"
    t.string   "billing_zip"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
    t.integer  "product_id"
  end

end
