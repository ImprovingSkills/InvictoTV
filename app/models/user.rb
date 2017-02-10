class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_one :profile, dependent: :destroy
  accepts_nested_attributes_for :profile, allow_destroy: true
  
  validates :email, uniqueness: true
  validates_confirmation_of :password_confirmation

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, 
         :omniauthable, :omniauth_providers => [:facebook]

  def self.from_omniauth(auth)
    @graph = Koala::Facebook::API.new(auth.credentials.token)
    info = @graph.get_object("me?fields=first_name,last_name,gender,email,birthday,picture.width(400),cover")
    fb_thumb = @graph.get_object("me?fields=picture")
    email = info["email"]
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.build_profile
      user.email = email ? email : "#{auth.uid}@change-me.com"
      user.password = Devise.friendly_token[0,20]
      user.profile.first_name = info["first_name"]
      user.profile.last_name = info["last_name"]
      user.profile.gender = info["gender"]
      user.profile.username = info["first_name"] + "-" + info["last_name"]
      user.profile.avatar = URI.parse(info["picture"]["data"]["url"])
      user.profile.cover = URI.parse(info["cover"]["source"])
      user.profile.fb_thumb = URI.parse(fb_thumb["picture"]["data"]["url"])
      user.save
    end      
  end

  def email_verified?
    if self.email
      if self.email.split('@')[1] == 'change-me.com'
        return false
      else
        return true
      end
    else
      return false
    end
  end

   def name
    profile.first_name
  end

  def last_name
    profile.last_name
  end

  def gender
    profile.gender
  end

  def full_name
    "#{name} #{last_name}"
  end


end
