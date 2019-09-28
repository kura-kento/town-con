class AddPairsDate < ActiveRecord::Migration[5.2]
  def change
    add_column :pairs, :date, :date
  end
end
