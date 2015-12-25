class RenameStackColName < ActiveRecord::Migration
  def change
    rename_column :stacks, :game_id_id, :game_id
    rename_column :stacks, :user_id_id, :user_id
  end
end
