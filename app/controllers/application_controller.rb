class ApplicationController < ActionController::Base

  #replaced this with CAS auth
  #y = YAML.load_file("#{Rails.root.to_s}/config/solr.yml")
  #user1 = y["user1"]
  #password1 = y["password1"]
  #http_basic_authenticate_with name: user1, password: password1
  
  #tried these to no avail, instead removed CSRF gem
  ##skip_before_action :verify_authenticity_token
  #protect_from_forgery prepend: true, with: :exception
  ##protect_from_forgery prepend: true, with: :null_session

  before_action :authenticate_user!

end
