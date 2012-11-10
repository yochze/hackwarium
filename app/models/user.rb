class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
      :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Default
  attr_accessible :email, :password, :password_confirmation, :remember_me

  # Added for Hackware
  attr_accessible :name, :birthday, :title, :profile_pic, :likes, :groups
  
  # Omniauth	
  attr_accessible :provider, :uid, :name, :oauth_token, :oauth_expires_at

  # Likes, Groups
  serialize :likes
  serialize :groups

  # Add Likes, Groups after creating User.
  after_create :get_likes_and_groups

  # Relationships
  has_many :posts
  has_many :comments
  has_many :impressions
  

 
# OAuth
  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end

# OAuth
  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
	  unless user
	     user = User.create(  name:auth.extra.raw_info.name,
	                         provider:auth.provider,
	                         uid:auth.uid,
	                         email:auth.info.email,
                           birthday:auth.extra.raw_info.birthday,
                           profile_pic:auth.info.image,
	                         oauth_token:auth.credentials.token,
	                         oauth_expires_at:Time.at(auth.credentials.expires_at),
	                         password:Devise.friendly_token[0,20]
	                         )
	  end
	  user
  end

  def facebook
    # This method is for Facebook Graph API with koala
    @facebook ||= Koala::Facebook::API.new(oauth_token)
  end
  
  def get_likes_and_groups
    self.likes = self.facebook.get_connection("me", "likes")
    self.groups = self.facebook.get_connection("me", "groups")
  end

end
