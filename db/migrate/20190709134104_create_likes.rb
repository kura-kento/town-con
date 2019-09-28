class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.string :title
      t.integer :peple, default:1
      t.string :image
      t.integer :creator_id
      t.boolean :permission , default:false

      t.timestamps
    end
  end
end
