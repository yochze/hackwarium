class CommentsController < ApplicationController

  def create
	    @post = Post.find(params[:post_id])
	    @comment = @post.comments.new(params[:comment])
	    @comment.user = current_user

	respond_to do |format|	    
	    if @comment.save
	    	format.js  # Ajax
	    	format.html { redirect_to @post }
	    else
	    	format.html { redirect_to @post }
	    end
	 end
  end
end
