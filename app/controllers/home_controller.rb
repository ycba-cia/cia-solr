class HomeController < ApplicationController

  before_action :solr_connect, only: [:confirm,:submit]

  def solr_connect
    y = YAML.load_file("#{Rails.root.to_s}/config/solr.yml")
    @solrs = Array.new
    @solr = RSolr.connect :url => y["url"]
    @solr2 = RSolr.connect :url => y["url2"]
    @solrs.push(@solr)
    @solrs.push(@solr2)
    @config_code = y["code"]

    as_hostname = y["as_hostname"]
    as_username = y["as_username"]
    as_password = y["as_password"]
    as_databasename = y["as_databasename"]
    sslca = y['sslca']
    sslca_path = "#{Rails.root.to_s}/#{sslca}"
    if @as_client.nil? or @as_client.closed?
      @as_client = Mysql2::Client.new(:host=>as_hostname,:username=>as_username,:password=>as_password,:database=>as_databasename,:sslca=>sslca_path)
    end
    puts "activitystream1 ping:#{@as_client.ping}"

  end

  def index
  end

  def confirm
    @id = params["id"]
    #@code = params["code"]
    #puts @code
    #puts @config_code
    #if @config_code.to_s == @code.to_s
    if true
      @ok = true
      @return = ""
      @found = false
      @found2 = false
      if insynch? == false
        @return = "<p><font color=\"red\">Warning indexes don't match!</font></p>"
      end
      @solrs.each_with_index do |solr, i|
        ii = i + 1
        @return += "<p><u>Index "+ii.to_s+"</u><p>"
        lookup = solr.select :params => { :fq => "id:\"#{@id}\"" }
        if lookup["response"]["numFound"] == 1
          title = ""
          author = ""
          @found = true
          title = lookup["response"]["docs"][0]["title_ss"][0] if lookup["response"]["docs"][0]["title_ss"]
          author = lookup["response"]["docs"][0]["author_ss"][0] if lookup["response"]["docs"][0]["author_ss"]
          @return += "<p><b>Title:</b>"+title+"</p>"
          @return += "<p><b>Author:</b>"+author+"</p>"
        else
          @return += "<p>ID <b>#{@id}</b> not found</p>"
        end
      end
      as_row_data = getAS(@id)
      if as_row_data == []
        @return +="<p>Manifest for <b>#{@id}</b> not found</p>"
      else
        @found2 = true
        @return += "<p><u>IIIF</u><p>"
        @return += "<p><b>To be deleted:</b>#{as_row_data[0][2]}</p>"
      end
    else
      @ok = false
    end
  end

  def submit
    if params["solr_id"].present?
      puts "in delete from solr"
      @solr_id = params["solr_id"]
      @solr.delete_by_id @solr_id
      @solr.commit
      @solr2.delete_by_id @solr_id
      @solr2.commit
    end
    if params["iiif_id"].present?
      puts "in delete from iiif"
      @iiif_id = params["iiif_id"]
      delete_to_actstream(@iiif_id)
    end
    end
  end

  def insynch?
    match = Array.new
    @solrs.each_with_index do |s, i|
      ii = i + 1
      lookup = s.select :params => { :fq => "id:\"#{@id}\"" }
      var = ""
      if lookup["response"]["numFound"] == 0
        var += "0"
      end
      if lookup["response"]["numFound"] == 1
        var += "1"
        if lookup["response"]["docs"][0]["title_ss"]
          var += lookup["response"]["docs"][0]["title_ss"][0]
        end
        if lookup["response"]["docs"][0]["author_ss"]
          var += lookup["response"]["docs"][0]["author_ss"][0]
        end
      end
      match[i] = var
      #puts s.inspect
      puts "Match#{ii.to_s}:#{match[i].inspect}"
    end
    insynch = match.all? {|x| x == match[0]}
    #puts "insynch #{insynch}"
    insynch
  end

  def getAS(id)
    row_data = []
    q = "select id,mdid,mdurl from asmetadata4 where mdid = '#{id}'"
    puts q
    s = @as_client.query(q)
    s.each do |row|
      row_data.push([row["id"],row["mdid"],row["mdurl"]])
    end
    puts "Row:#{row_data.inspect}"
    row_data
  end

  def delete_to_actstream(id)
    q = "UPDATE asmetadata4 set created=NOW(),statustype='delete' "+
        "where mdid = '#{id}'"
    puts q
    @as_client.query(q)
  end

