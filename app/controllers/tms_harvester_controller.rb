class TmsHarvesterController < ApplicationController

  def index
    @tab = params[:tab] == 'list' ? 'list' : 'counts'

    @counts = MetadataRecord::STATUSES.index_with { |status| MetadataRecord.where(status: status).count }

    @status = MetadataRecord::STATUSES.include?(params[:status]) ? params[:status] : MetadataRecord::STATUSES.first

    @records = MetadataRecord
                 .select(:local_identifier, :created_at, :updated_at)
                 .where(status: @status)
                 .order(Arel.sql("CAST(local_identifier AS INTEGER) asc"))
                 .page(params[:page])
                 .per(15)
  end
end
