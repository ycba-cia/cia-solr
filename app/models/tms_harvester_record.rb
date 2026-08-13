class TmsHarvesterRecord < ApplicationRecord
  self.abstract_class = true
  connects_to database: { writing: :tms_harvester, reading: :tms_harvester }
end
