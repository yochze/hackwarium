class Post < ActiveRecord::Base
  attr_accessible :content, :title, :user_id

  has_many :comments
  has_many :impressions
  
  belongs_to :user
end
