class CreateCreaters < ActiveRecord::Migration
  def change
    create_table :creaters do |t|
      t.string :name
      t.string :furigana

      t.timestamps
    end
  end
end
