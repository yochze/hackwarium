class AdminController < ApplicationController
  
  before_filter :authenticate_admin, :except => [ :users ]
  
  def index
  	@impressions = Impression.all
    @users = User.all
    @posts = Post.all
    @comments = Comment.all
  end

  def stats
  end

  def users
  end
end
