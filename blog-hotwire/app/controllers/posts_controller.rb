# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :load_post, only: %i[show edit update destroy]
  authorize_resource

  def index
    @pagy, @posts = pagy(Post.order(created_at: :desc).includes(:user), items: 3)
    # @pagy, @posts = pagy(Post.order(created_at: :desc).includes(:user, :taggeds, :tags), items: 10)

    render 'posts/scrollable_post' if params[:page]
  end

  def show; end

  def new
    @post = Post.new
  end

  def edit; end

  def own_posts
    @posts = current_user.posts.includes(:tags)
  end

  def create
    @post = Post.new(post_params.except(:tags))
    @post.user = current_user
    create_or_delete_post_tags(@post, params[:post][:tags])

    if @post.save!
      redirect_to post_path(@post, locale: I18n.locale), notice: 'Post was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    create_or_delete_post_tags(@post, params[:post][:tags])
    if @post.update(post_params.except(:tags))
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

  def create_or_delete_post_tags(post, tags)
    return if tags.blank?

    current_post_tags = post.tags.pluck(:name, :id).to_h
    tags_to_delete = current_post_tags
    tags = JSON.parse(tags).map { |hash| hash['value'] }
    tags.each do |tag|
      if current_post_tags.key?(tag)
        tags_to_delete.delete(tag)
      else
        post.tags << Tag.find_or_create_by(name: tag)
      end
    end
    post.taggeds.where(tag_id: tags_to_delete.values).destroy_all if tags_to_delete.any?
  end

  def load_post
    @post = Post.includes(:taggeds, :tags).find(params[:id])
    @tags = @post.tags.pluck(:name)
  end

  def post_params
    params.require(:post).permit(:title, :body, :tags)
  end
end
