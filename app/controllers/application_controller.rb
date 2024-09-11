class ApplicationController < ActionController::Base

  #y = YAML.load_file("#{Rails.root.to_s}/config/solr.yml")
  #user1 = y["user1"]
  #password1 = y["password1"]
  #http_basic_authenticate_with name: user1, password: password1

  before_action :authenticate_user!

end
