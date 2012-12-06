class CommentsController < ApplicationController

  def create
	    @post = Post.find(params[:post_id])
	    @comment = @post.comments.new(params[:comment])
	    @comment.user = current_user

	respond_to do |format|	    
	    if @comment.save
        @post.updated_at = @comment.created_at
        @post.save! 	
        format.js  # Ajax
	    	format.html { redirect_to @post }
	    else
	    	format.html { redirect_to @post }
	    end
	 end
  end


def destroy
    @post = Post.find(params[:id])
    @comment = @post.comments.find(params[:post_id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to @post }
      format.json { head :no_content }
    end
end

  def vote_up
    begin
      @post = Post.find(params[:id])
      @comment = @post.comments.find(params[:post_id])
      if user_signed_in? && current_user != @comment.user
        current_user.vote_for(@comment)
        @comment.user.positive_rank += 10
        @comment.user.save
        redirect_to @post
      else
        redirect_to @post
      end
    rescue ActiveRecord::RecordInvalid
      redirect_to @post
    end
  end

  def vote_down
    begin
      @post = Post.find(params[:id])
      @comment = @post.comments.find(params[:post_id])
      if user_signed_in? && current_user != @comment.user
        current_user.vote_against(@comment)
        @comment.user.negative_rank += 5
        @comment.user.save
        redirect_to @post
      else
        redirect_to @post
      end
    rescue ActiveRecord::RecordInvalid
      redirect_to @post
    end
  end


end
