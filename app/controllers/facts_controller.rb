class FactsController < ApplicationController

  def index
    
    if !(user_signed_in? || current_user.admin?)
      @fact = Fact.all
    else
      redirect_to posts_path
    end

  end

	def new
		@fact = Fact.new

    	respond_to do |format|
      		format.html # new.html.erb
    	end
	end

	def create
		@fact = Fact.new(params[:fact])
    	@fact.user = current_user
    	
    	respond_to do |format|
      		if @fact.save
        		format.html { redirect_to posts_path, notice: '' }
   		   else
        		format.html { render action: "new" }
        	end
	  	end

	end
end