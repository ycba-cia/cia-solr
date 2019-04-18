class HomeController < ApplicationController

  before_action :solr_connect, only: [:confirm,:submit]

  def solr_connect
    y = YAML.load_file("#{Rails.root.to_s}/config/solr.yml")
    @solr = RSolr.connect :url => y["url"]
  end

  def index
  end

  def confirm
    @id = params["id"]
    @code = params["code"]
    code = "132435467"
    if code == @code
      @ok = true
      lookup = @solr.select :params => { :fq => "id:\"#{@id}\"" }
      if lookup["response"]["numFound"] == 1
        title = ""
        author = ""
        @found = true
        title = lookup["response"]["docs"][0]["title_ss"][0] if lookup["response"]["docs"][0]["title_ss"][0]
        author = lookup["response"]["docs"][0]["author_ss"][0] if lookup["response"]["docs"][0]["author_ss"][0]
        @return = "<p><b>Title:</b>"+title+"</p>"
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
    #@solr.delete_by_id @solr_id
  end
end
