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

  def add_impression(user)
    if !user.nil?
      @post.impressions.create(ip_address: request.remote_ip, useragent: request.user_agent, referrer: request.referer, user_id: user.id )
    else
      @post.impressions.create(ip_address: request.remote_ip, useragent: request.user_agent, referrer: request.referer, user_id: nil )
    end 
  end


end
