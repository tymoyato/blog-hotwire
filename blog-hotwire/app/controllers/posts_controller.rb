class PostsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_post, only: %i[show edit update destroy]

  def index
    @posts = Post.order(created_at: :desc).limit(10).includes(:user)
  end

  def show; end

  def new
    @post = Post.new
  end

  def edit; end

  def own_posts
    @posts = current_user.posts
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user

    if @post.save!
      redirect_to post_path(@post, locale: I18n.locale), notice: 'Post was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post, locale: I18n.locale), notice: 'Post was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy!

    redirect_to posts_url, notice: 'Post was successfully destroyed.'
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
