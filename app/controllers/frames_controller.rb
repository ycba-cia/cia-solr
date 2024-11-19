class FramesController < ApplicationController

  def index
  end

  def confirm
    @idtype = params["idtype"]
    id = params["id"]

    @errormsg = ""
    if id.length == 0
      @errormsg += "<p>ID must be populated.</p>"
    end
    if @idtype == "objectid"
      unless id.to_i.to_s == id
        @errormsg += "<p>Object ID must be an integer</p>"
      end
    end

    if @errormsg.length == 0
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
  end

  def submit
    #if params["solr_id"].present?
    objectID = params["objectID"]
    objectNumber = params["objectNumber"]
    frameObjectID = params["frameObjectID"]
    frameObjectNumber = params["frameObjectNumber"]

    @errormsg = ""
    if objectID.length == 0 || objectNumber.length == 0 || frameObjectID.length == 0 || frameObjectNumber.length == 0
      @errormsg += "<p>All fields must be populated.</p>"
    end
    unless objectID.to_i.to_s == objectID
      @errormsg += "<p>ObjectID must be an integer.</p>"
    end
    unless frameObjectID.to_i.to_s == frameObjectID
      @errormsg += "<p>FrameObjectID must be an integer.</p>"
    end
    if @errormsg.length == 0
      Frame.where(objectID: objectID).update_all(frameObjectID: frameObjectID, frameObjectNumber: frameObjectNumber)
      f = Frame.where(objectID: objectID).first
      @objectID= f.ObjectID
      @objectNumber = f.ObjectNumber
      @frameObjectID = f.FrameObjectID
      @frameObjectNumber = f.FrameObjectNumber
    end
  end

  def new
    #if params["solr_id"].present?
    objectID = params["objectID"]
    objectNumber = params["objectNumber"]
    frameObjectID = params["frameObjectID"]
    frameObjectNumber = params["frameObjectNumber"]

    @errormsg = ""
    if objectID.length == 0 || objectNumber.length == 0 || frameObjectID.length == 0 || frameObjectNumber.length == 0
      @errormsg += "<p>All fields must be populated.</p>"
    end
    unless objectID.to_i.to_s == objectID
      @errormsg += "<p>ObjectID must be an integer.</p>"
    end
    unless frameObjectID.to_i.to_s == frameObjectID
      @errormsg += "<p>FrameObjectID must be an integer.</p>"
    end
    if @errormsg.length == 0
    #case sensitive
      f = Frame.create(ObjectID: objectID, ObjectNumber: objectNumber, FrameObjectID: frameObjectID, FrameObjectNumber: frameObjectNumber)
      @objectID= f.ObjectID
      @objectNumber = f.ObjectNumber
      @frameObjectID = f.FrameObjectID
      @frameObjectNumber = f.FrameObjectNumber
    end
  end
end