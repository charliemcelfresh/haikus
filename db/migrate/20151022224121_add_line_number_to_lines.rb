class AddLineNumberToLines < ActiveRecord::Migration
  def change
    add_column :lines, :line_number, :integer
  end
end
