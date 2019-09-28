class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.date :date
      t.boolean :deadline_men, default:true
      t.boolean :deadline_women, default:true
      t.integer :capacity

      t.timestamps
    end
  end
end
