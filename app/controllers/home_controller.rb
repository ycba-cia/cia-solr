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
  end

  def index
  end

  def confirm
    @id = params["id"]
    @code = params["code"]
    #puts @code
    #puts @config_code
    if @config_code.to_s == @code.to_s
      @ok = true
      @return = ""
      if insynch? == false
        @return = "<p><font color=\"red\">Warning indexes don't match!</font></p>"
      end
      lookup = @solr.select :params => { :fq => "id:\"#{@id}\"" }
      if lookup["response"]["numFound"] == 1
        title = ""
        author = ""
        @found = true
        title = lookup["response"]["docs"][0]["title_ss"][0] if lookup["response"]["docs"][0]["title_ss"]
        author = lookup["response"]["docs"][0]["author_ss"][0] if lookup["response"]["docs"][0]["author_ss"]
        @return += "<p><b>Title:</b>"+title+"</p>"
        @return += "<p><b>Author:</b>"+author+"</p>"
      else
        @found = false
        @return = "<p>ID <b>#{@id}</b> not found</p>"
      end
    else
      @ok = false
    end
  end

  def submit
    @solr_id = params["solr_id"]
    @solr.delete_by_id @solr_id
    @solr.commit
    @solr2.delete_by_id @solr_id
    @solr2.commit
  end

  def insynch?
    match = Array.new
    @solrs.each_with_index do |s, i|
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
      puts match[i].inspect
    end
    insynch = match.all? {|x| x == match[0]}
    #puts "insynch #{insynch}"
    insynch
  end
end
