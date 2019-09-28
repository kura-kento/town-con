class CreateMatches < ActiveRecord::Migration[5.2]
  def change
    create_table :matches do |t|
      t.integer :user_id
      t.integer :matched_id
      t.integer :evaluation

      t.timestamps
    end
  end
end
