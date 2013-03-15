class BlogsController < ApplicationController
  before_filter :load_blog, :except => [:index, :new, :create]

  def index
    authorize! :read, Blog
    @blogs = Blog.sorted.all
  end

  def show
    authorize! :read, @blog
  end

  def new
    authorize! :create, Blog
    @blog = Blog.new
  end

  def create
    authorize! :create, Blog
    @blog = Blog.new(params[:blog])
    @blog.user = current_user
    logger.info current_user
    if @blog.save
      redirect_to @blog, notice: 'Blog was successfully created.'
    else
      render action: "new"
    end
  end

  def edit
    authorize! :update, @blog
  end

  def update
    authorize! :update, @blog

    if @blog.update_attributes(params[:blog])
      redirect_to @blog, notice: 'Blog was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    authorize! :destroy, @blog
    @blog.destroy

    redirect_to blogs_url
  end

  private
  def load_blog
    @blog = Blog.find(params[:id])
  end
end
