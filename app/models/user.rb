class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # ERJ 9/11/2024 - added :omniauthable and from_omniauth and get_modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable

  def self.from_omniauth(auth)
    find_by(provider: auth.provider, uid: auth.uid)
  end

  def self.get_modules(auth)
    users = User.where("provider = ? and uid = ?", auth.provider,auth.uid).pluck(:module)
    users
  end

  #ERJ 9/11/2024
  #User.create!(:email=>"eric.james@yale.edu",:password=>"default",:provider=>"cas",:uid=>"ermadmix",:module=>"default",:created_at=>DateTime.now,:updated_at=>DateTime.now)
  #User.all
end
