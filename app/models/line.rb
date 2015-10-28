class Line < ActiveRecord::Base
  has_many :haiku_lines
  has_many :haikus, through: :haiku_lines
  #validates :haiku, presence: true
  validates :content, presence: true
end
