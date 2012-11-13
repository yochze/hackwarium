class Fact < ActiveRecord::Base
  attr_accessible :content, :source, :user_id
  attr_accessible :created_at

  validates :content, :presence => true, :length => { :minimum => 80, :maximum => 300 }

  belongs_to :user

  def self.random_fact
  	Fact.all.sample
  end

end
