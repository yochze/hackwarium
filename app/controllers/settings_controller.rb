class SettingsController < ApplicationController

  before_filter :authenticate_admin, :only => [:admin_panel]

	def account
    @user = current_user
    if request.put?
      @user.update_attributes(params[:user])
      # flash[:notice] = "Account data was successfully updated."
      redirect_to current_user
    end
  end


  def splash
  	if user_signed_in?
  		redirect_to posts_url
  	end
  end

  def admin_panel
    @impressions = Impression.all
    @users = User.all
    @posts = Post.all
    @comments = Comment.all
  end


end
