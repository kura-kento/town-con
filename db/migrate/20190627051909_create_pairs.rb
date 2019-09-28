class CreatePairs < ActiveRecord::Migration[5.2]
  def change
    create_table :pairs do |t|
      t.text :one
      t.text :two
      t.text :three
      t.text :four
      t.text :five
      t.text :six
      t.text :seven
      t.text :eight

      t.timestamps
    end
  end
end
