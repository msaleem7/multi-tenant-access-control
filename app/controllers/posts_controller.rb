class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_space
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    authorize @space, :show?
    @posts = @space.posts.includes(:user).order(created_at: :desc)
  end

  def show
    authorize @post
  end

  def new
    @post = @space.posts.new
    authorize @post
  end

  def create
    @post = @space.posts.new(post_params)
    @post.user = current_user
    
    authorize @post

    if @post.save
      redirect_to post_path(@post), notice: 'Post was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @post
  end

  def update
    authorize @post
    
    if @post.update(post_params)
      redirect_to post_path(@post), notice: 'Post was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @post
    
    @post.destroy
    redirect_to space_posts_path(@space), notice: 'Post was successfully deleted.'
  end

  private

  def set_space
    if params[:space_id]
      @space = Space.find(params[:space_id])
    elsif params[:id]
      @post = Post.find(params[:id])
      @space = @post.space
    end
  end

  def set_post
    @post ||= @space.posts.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :age_rating)
  end
end
