class AddColumnpairs < ActiveRecord::Migration[5.2]
  def down
    remove_column :pair, :three, :text
    remove_column :pair, :four, :text
    remove_column :pair, :five, :text
    remove_column :pair, :six, :text
    remove_column :pair, :seven, :text
    remove_column :pair, :eight, :text
  end
end
