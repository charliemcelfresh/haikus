class RandomHaiku < Haiku
  before_validation :generate_random_haiku
  validate :unique_haiku

  def generate_random_haiku
    if Line.count < 5
      errors.add(:base, "Not enough lines")
    elsif self.lines.empty?
      3.times do |i|
        i+=1
        self.lines << Line.where(line_number: i).sample
      end
    else
      
    end
  end

  def unique_haiku
    Haiku.find_each do |h|
      if h.lines == self.lines
        errors.add(:base, "Haiku exists")
      end
    end
  end
end
