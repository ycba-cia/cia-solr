class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # See https://github.com/omniauth/omniauth/wiki/FAQ#rails-session-is-clobbered-after-callback-on-developer-strategy
  skip_before_action :verify_authenticity_token, only: :cas

  def cas
    auth = request.env["omniauth.auth"]
    puts("test: #{auth}")

    @user = User.from_omniauth(auth)
    if @user.nil? == false && @user.persisted?
      puts "authenticated!"
      sign_in @user, event: :authentication
      redirect_to home_index_path
      #set_flash_message(:notice, :success, kind: "CAS") if is_navigational_format?
    else
      puts "user #{auth['uid']} not found for #{auth['provider']}"
      redirect_to unauth_path
      #set_flash_message(:notice, :success, kind: "CAS") if is_navigational_format?
    end
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    #@user = User.from_omniauth(request.env["omniauth.auth"])

    #if @user.persisted?
    #  sign_in_and_redirect @user, event: :authentication # this will throw if @user is not activated
    #  set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
    #else
    #  session["devise.facebook_data"] = request.env["omniauth.auth"].except(:extra) # Removing extra as it can overflow some session stores
    #  redirect_to new_user_registration_url
    #end
  end

  def failure
    #redirect_to root_path
    render :plain => params.inspect
  end
end