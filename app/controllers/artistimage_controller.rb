require 'pp'
class ArtistimageController < ApplicationController

  #before_action :solr_connect, only: [:confirm,:submit]
  #after_action :solr_close, only: [:confirm,:submit]

  #def solr_close
  #  @as_client.close
  #end

  #def solr_connect
  #  y = YAML.load_file("#{Rails.root.to_s}/config/solr.yml")
  #  @solrs = Array.new
  #  @solr = RSolr.connect :url => y["url"]
  #  @solr2 = RSolr.connect :url => y["url2"]
  #  @solrs.push(@solr)
  #  @solrs.push(@solr2)
  #  @config_code = y["code"]
  #end
  #=end

  def index
    cmstype = params["cmstype"]
    cmsid = params["cmsid"]
  end

  def confirm
  end

  def submit
  end

  def get_tms_client
    env_file = File.join(Rails.root, 'config', 'connections.yml')
    db = Hash.new
    YAML.load(File.open(env_file)).each do |key, value|
      db[key.to_s] = value
    end if File.exist?(env_file)
    tds = TinyTds::Client.new(:username => db["tmsuser"],:password => db["tmspw"],:host => db["tmshost"],:database => db["databaseName"])
    r = tds.execute("SET TEXTSIZE -1")
    return tds
  end

  def getconstituentdata
    nametype = params["nametype"]
    name = params["name"]
    client = get_tms_client
    q = %Q/ select ConstituentID,DisplayName,DisplayDate from [TMS].[dbo].[Constituents] where #{nametype} = '#{name}'/
    #puts "Q:#{q}"
    s = client.execute(q)
    rows = Array.new
    s.each do |r|
      #row.append([r["ConstituentID"],r["DisplayName"],r["DisplayDate"]])
      rows.append(r)
    end
    s.cancel
    client.close
    render :json => JSON(rows)
  end

  def getconstituent_by_id(id)
    client = get_tms_client
    q = %Q/ select ConstituentID,DisplayName,DisplayDate from [TMS].[dbo].[Constituents] where ConstituentID = #{id}/
    #puts "Q:#{q}"
    s = client.execute(q)
    rows = Array.new
    s.each do |r|
      #row.append([r["ConstituentID"],r["DisplayName"],r["DisplayDate"]])
      rows.append(r)
    end
    s.cancel
    client.close
    rows[0]["DisplayName"] = "null" if rows[0]["DisplayName"].nil?
    rows[0]["DisplayDate"] = "null" if rows[0]["DisplayDate"].nil?
    return rows[0]["ConstituentID"],rows[0]["DisplayName"],rows[0]["DisplayDate"]
  end

  def confirm
    @id = params["id"]
    @image = params["image"]
    @thumbnail = params["thumbnail"]
    @conid, @displayName,@displayDate = getconstituent_by_id(@id)
    a = ArtistHeroImages.where(artistid: @id)
    @length = a.length
    if @length == 1
      @currimage = a[0]["image"]
      @currthumbnail = a[0]["thumbnail"]
    end
  end

  def update
    @id = params["id"]
    @image = params["image"]
    @thumbnail = params["thumbnail"]
    a = ArtistHeroImages.where(artistid: @id)
    if a.length == 1
      a = a.first
      a.artistid = @id
      a.image = @image
      a.thumbnail = @thumbnail
      a.updated_at = DateTime.now
      a.save!
    else
      a = ArtistHeroImages.new
      a.artistid = @id
      a.image = @image
      a.thumbnail = @thumbnail
      a.created_at = DateTime.now
      a.updated_at = DateTime.now
      a.save!
    end
    @saved = a
  end

end
