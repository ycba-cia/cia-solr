class TmsHarvesterController < ApplicationController

  def index
    @tab = params[:tab] == 'list' ? 'list' : 'counts'

    @counts = MetadataRecord::STATUSES.index_with { |status| MetadataRecord.where(status: status).count }

    @status = MetadataRecord::STATUSES.include?(params[:status]) ? params[:status] : MetadataRecord::STATUSES.first

    @records = MetadataRecord
                 .select(:id, :local_identifier, :created_at, :updated_at, :diff)
                 .where(status: @status)
                 .order(Arel.sql("CAST(local_identifier AS INTEGER) asc"))
                 .page(params[:page])
                 .per(15)

    @harvester_link = load_harvester_link
  end

  private

  def load_harvester_link
    connections_file = File.join(Rails.root, 'config', 'connections.yml')
    return nil unless File.exist?(connections_file)

    YAML.load_file(connections_file)['harvesterLink']
  end
end
