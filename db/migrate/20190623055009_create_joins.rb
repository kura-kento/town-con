class CreateJoins < ActiveRecord::Migration[5.2]
  def change
    create_table :joins do |t|
      t.integer "user_id"
      t.string "gender"
      t.date "date"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  end
end
