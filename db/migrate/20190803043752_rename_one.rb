class RenameOne < ActiveRecord::Migration[5.2]
  def change
    rename_column :pairs, :one, :men
    rename_column :pairs, :two, :women
  end
end
