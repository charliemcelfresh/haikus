class Haiku < ActiveRecord::Base
  has_many :haiku_lines
  has_many :lines, through: :haiku_lines, before_add: [:limit_number_of_lines, :add_line_number]
  accepts_nested_attributes_for :lines
  validates :lines, presence: true

  def limit_number_of_lines(new_line)
    raise Exception.new('Haiku has three lines') if lines.size > 3
  end

  def add_line_number(line)
    if line.line_number.blank?
      self.save
      line.line_number = self.lines.count + 1
    end
  end

end
