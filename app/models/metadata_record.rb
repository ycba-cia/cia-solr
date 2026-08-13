class MetadataRecord < TmsHarvesterRecord
  self.table_name = 'metadata_record'

  STATUSES = %w[create same update stale].freeze
end
