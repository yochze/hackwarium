class SettingsController < ApplicationController
	def account
    @user = current_user
    if request.put?
      @user.update_attributes(params[:user])
      # flash[:notice] = "Account data was successfully updated."
      redirect_to current_user
    end
  end
end
