# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20081219172618) do

  create_table "releases", :force => true do |t|
    t.string  "name"
    t.string  "description"
    t.string  "image"
    t.string  "zip"
    t.date    "date",        :default => '2008-12-24'
    t.boolean "publish",     :default => false
    t.integer "position"
    t.integer "nr"
  end

  create_table "tracks", :force => true do |t|
    t.string  "name"
    t.integer "position"
    t.string  "internal"
    t.string  "file"
    t.integer "release_id"
    t.float   "length"
  end

  create_table "users", :force => true do |t|
    t.string "name"
    t.string "hashed_password"
  end

end
