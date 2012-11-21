class ApplicationController < ActionController::Base
  protect_from_forgery

  def is_admin
    if !(user_signed_in? && user.admin?)
      redirect_to posts_path
    end
  end

  def authenticate
    if !user_signed_in?
      redirect_to posts_path
    end
  end

  def authenticate_admin
    if !(user_signed_in? && current_user.admin?)
      redirect_to posts_path
    end
  end



  def add_impression(user)
    if !user.nil?
      @post.impressions.create(ip_address: request.remote_ip, useragent: request.user_agent, referrer: request.referer, user_id: user.id )
    else
      @post.impressions.create(ip_address: request.remote_ip, useragent: request.user_agent, referrer: request.referer, user_id: nil )
    end 
  end

  def vote_up_post(post)
      begin
      # @post = Post.find(params[:id])
      # @comment = @post.comments.find(params[:post_id])
      if user_signed_in? && current_user != post.user
        current_user.vote_for(post)
        post.user.positive_rank += 1
        post.user.save
        redirect_to post
      else
        redirect_to post
      end
    rescue ActiveRecord::RecordInvalid
      redirect_to post
    end
  end

  def vote_down_post(post)
      begin
      
      if user_signed_in? && current_user != post.user
        current_user.vote_against(post)
        post.user.negative_rank += 1
        post.user.save
        redirect_to post
      else
        redirect_to post
      end
    rescue ActiveRecord::RecordInvalid
      redirect_to post
    end
  end


end
