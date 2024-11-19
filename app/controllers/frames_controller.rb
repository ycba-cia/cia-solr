class FramesController < ApplicationController

  def index
  end

  def confirm
    @idtype = params["idtype"]
    id = params["id"]
    if @idtype == "objectid"
      @objectID = id
      f = Frame.where(:objectid => id).first
      if f.nil?
        @notfound = id
      else
        @frameObjectID = f.FrameObjectID
        @objectNumber = f.ObjectNumber
        @frameObjectNumber = f.FrameObjectNumber
      end
    end
    if @idtype == "accnumber"
      @objectNumber = id
      f = Frame.where(:objectnumber => id).first
      if f.nil?
        @notfound = id
      else
        @frameObjectID = f.FrameObjectID
        @objectID = f.ObjectID
        @frameObjectNumber = f.FrameObjectNumber
      end
    end
  end

  def submit
    #if params["solr_id"].present?
    @objectID = params["objectID"]
    @objectNumber = params["objectNumber"]
    @frameObjectID = params["frameObjectID"]
    @frameObjectNumber = params["frameObjectNumber"]
  end
end


