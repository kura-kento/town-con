class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string "gender"
      t.string "name"
      t.string "email"
      t.string "password"
      t.integer "age"
      t.text "like"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  end
end
