# frozen_string_literal: true

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

ActiveRecord::Schema.define(version: 20_190_614_111_525) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'comment_threads', force: :cascade do |t|
    t.string 'commentable_type'
    t.bigint 'commentable_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[commentable_type commentable_id], name: 'index_comment_threads_on_commentable_type_and_commentable_id'
  end

  create_table 'comments', force: :cascade do |t|
    t.text 'comment'
    t.integer 'note'
    t.bigint 'user_id'
    t.bigint 'comment_thread_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['comment_thread_id'], name: 'index_comments_on_comment_thread_id'
    t.index ['user_id'], name: 'index_comments_on_user_id'
  end

  create_table 'crawl_users', force: :cascade do |t|
    t.bigint 'crawl_id'
    t.bigint 'user_id'
    t.boolean 'accepted'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['crawl_id'], name: 'index_crawl_users_on_crawl_id'
    t.index ['user_id'], name: 'index_crawl_users_on_user_id'
  end

  create_table 'crawls', force: :cascade do |t|
    t.string 'name'
    t.text 'description'
    t.datetime 'event_date'
    t.string 'status'
    t.bigint 'user_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_crawls_on_user_id'
  end

  create_table 'events', force: :cascade do |t|
    t.string 'name'
    t.text 'description'
    t.datetime 'event_date'
    t.bigint 'poi_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['poi_id'], name: 'index_events_on_poi_id'
  end

  create_table 'friendships', force: :cascade do |t|
    t.bigint 'user_id'
    t.bigint 'friend_id'
    t.boolean 'accepted'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['friend_id'], name: 'index_friendships_on_friend_id'
    t.index ['user_id'], name: 'index_friendships_on_user_id'
  end

  create_table 'jwt_blacklist', force: :cascade do |t|
    t.string 'jti', null: false
    t.index ['jti'], name: 'index_jwt_blacklist_on_jti'
  end

  create_table 'menu_items', force: :cascade do |t|
    t.string 'name'
    t.text 'description'
    t.float 'price'
    t.bigint 'poi_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['poi_id'], name: 'index_menu_items_on_poi_id'
  end

  create_table 'opening_hours', force: :cascade do |t|
    t.integer 'weekday'
    t.time 'opening'
    t.time 'closing'
    t.bigint 'poi_id'
    t.index ['poi_id'], name: 'index_opening_hours_on_poi_id'
  end

  create_table 'poi_crawls', force: :cascade do |t|
    t.bigint 'poi_id'
    t.bigint 'crawl_id'
    t.index ['crawl_id'], name: 'index_poi_crawls_on_crawl_id'
    t.index ['poi_id'], name: 'index_poi_crawls_on_poi_id'
  end

  create_table 'poi_users', force: :cascade do |t|
    t.bigint 'poi_id'
    t.bigint 'user_id'
    t.boolean 'accepted'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['poi_id'], name: 'index_poi_users_on_poi_id'
    t.index ['user_id'], name: 'index_poi_users_on_user_id'
  end

  create_table 'pois', force: :cascade do |t|
    t.string 'name'
    t.string 'address'
    t.string 'coordinates'
    t.string 'phone'
    t.text 'description'
    t.string 'family', default: 'pub'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'firstname'
    t.string 'lastname'
    t.string 'roles'
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end
end
