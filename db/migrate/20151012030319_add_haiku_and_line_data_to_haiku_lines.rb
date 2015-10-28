class AddHaikuAndLineDataToHaikuLines < ActiveRecord::Migration
  def change
    Line.find_each do |line|
      HaikuLine.create(
        line_id: line.id,
        haiku_id: line.haiku.id,
        created_at: line.created_at,
        updated_at: line.updated_at
      )
    end
  end
end
