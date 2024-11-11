class FramesRecord < ApplicationRecord
  self.abstract_class = true
  connects_to database: { writing: :frames, reading: :frames }
end