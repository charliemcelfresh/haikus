class HaikuLine < ActiveRecord::Base
  belongs_to :haiku
  belongs_to :line
end
