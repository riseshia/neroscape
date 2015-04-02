class AddModelToGame < ActiveRecord::Migration
  def change
    add_column :games, :model, :string
  end
end
