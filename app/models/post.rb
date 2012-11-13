class Post < ActiveRecord::Base
  attr_accessible :content, :title, :user_id

  has_many :comments
  has_many :impressions
  
  belongs_to :user

  # Validations

  validates :content, :presence => true, :length => { :minimum => 10 }
  validates :title, :presence => true


  def self.search(search)
    if search
      find(:all, :conditions => ['content LIKE ?', "%#{search}%"]) 
    else
      find(:all)
    end
  end

end
