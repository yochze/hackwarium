class Impression < ActiveRecord::Base
  attr_accessible :ip_address, :post_id, :referrer, :user_id, :useragent

  belongs_to :post
  belongs_to :user

end
