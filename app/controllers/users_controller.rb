class UsersController < ApplicationController
	
	def show
		# @user = User.find(params[:id])
		redirect_to posts_url
	end

end
