class PostsController < ApplicationController
  helper :all
    
  before_filter :authenticate, :except => [:show, :index]
  
  def index
    
    @posts = Post.order("sticky DESC, updated_at DESC").page(params[:page]).per_page(10)

    @random_user = User.all.sample
    @random_fact = Fact.random_fact
    
    respond_to do |format|
      format.html # index.html.erb
      format.js
      format.json { render json: @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])
    add_impression(current_user) # AppController method

    @random_post = Post.all.sample
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
    if !(@post.user == current_user || current_user.admin?)
      redirect_to posts_path
    end
  end

  def mark_sticky
    @post = Post.find(params[:id])
    if !current_user.admin?
      redirect_to @post
    else
      if @post.sticky?
        @post.sticky = false
      else
        @post.sticky = true
      end
      @post.save!
      redirect_to @post
    end
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(params[:post])
    @post.user = current_user
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: '' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: '' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end
  
  def vote_up
    @post = Post.find(params[:id])
    vote_up_post(@post)
  end

  def vote_down
    @post = Post.find(params[:id])
    vote_down_post(@post)
  end

  # def search 
  #   @posts = Post.search(params[:search])
  # end

end
