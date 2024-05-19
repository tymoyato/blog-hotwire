# frozen_string_literal: true

class TagsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_tag, only: %i[show edit update destroy]
  authorize_resource

  def index
    @tags = Tag.all
  end

  def show; end

  def new
    @tag = Tag.new
  end

  def edit; end

  def create
    @tag = Tag.new(tag_params)

    if @tag.save
      redirect_to tags_path, notice: 'Tag was successfully created.'
    else
      render :new
    end
  end

  def update
    if @tag.update
      redirect_to tags_path, notice: 'Tag was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @tag.destroy!

    redirect_to tags_path, notice: 'Post was successfully destroyed.'
  end

  private

  def load_tag
    @tag = Tag.find(params[:id])
  end

  def tag_params
    params.require(:tag).permit(:name)
  end
end
