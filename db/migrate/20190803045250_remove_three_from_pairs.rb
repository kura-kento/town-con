class RemoveThreeFromPairs < ActiveRecord::Migration[5.2]
  def change
    remove_column :pairs, :three, :text
    remove_column :pairs, :four, :text
    remove_column :pairs, :five, :text
    remove_column :pairs, :six, :text
    remove_column :pairs, :seven, :text
    remove_column :pairs, :eight, :text
  end
end
