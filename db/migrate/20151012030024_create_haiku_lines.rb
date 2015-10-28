class CreateHaikuLines < ActiveRecord::Migration
  def change
    create_table :haiku_lines do |t|
      t.integer :line_id
      t.integer :haiku_id

      t.timestamps null: false
    end
    add_index :haiku_lines, :haiku_id
    add_index :haiku_lines, :line_id
  end
end
