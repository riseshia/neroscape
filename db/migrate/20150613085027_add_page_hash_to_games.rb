class AddPageHashToGames < ActiveRecord::Migration
  def change
    add_column :games, :page_hash, :string
  end
end
