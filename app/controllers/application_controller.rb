class ApplicationController < ActionController::Base
  before_action :store_user_location!, if: :storable_location?
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

  private

  # Its important that the location is NOT stored if:
  # - The request is a part of the Devise controller
  # - The request format is not HTML
  # - A `sign_in` request
  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr? && !request.path.match(/auth\//)
  end

  def store_user_location!
    # capture the request path and store it in the session
    session[:user_return_to] = request.fullpath
  end

end
