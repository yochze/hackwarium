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

  def vote_up
    begin
      @post = Post.find(params[:id])
      current_user.vote_for(@comment = @post.comments.find(params[:post_id]))
      current_user.positive_rank += 1
      current_user.save
      redirect_to @post
    rescue ActiveRecord::RecordInvalid
      redirect_to @post
    end
  end

  def vote_down
    begin
      @post = Post.find(params[:id])
      current_user.vote_against(@comment = @post.comments.find(params[:post_id]))
      current_user.negative_rank += 1
      current_user.save
      redirect_to @post
    rescue ActiveRecord::RecordInvalid
      redirect_to @post
    end
  end

end
