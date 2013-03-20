class BlogsController < ApplicationController
  before_filter :load_blog, :except => [:index, :new, :create]

  def index
    authorize! :read, Blog
    @blogs = Blog.sorted.all

    respond_to do |format|
      format.html
      format.json { render :json => @blogs, :only => [:id, :title, :text, :created_at], :include => {:user => {:only => [:id, :name]} } }
    end
  end

  def show
    authorize! :read, @blog
    @comment = Comment.new
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

  def comment
    authorize! :comment, @blog
    @comment = Comment.new(params[:comment])
    @comment.user = current_user
    @comment.commentable = @blog
    if @comment.save
      redirect_to @blog, :anchor => "comment-#{@comment.id}"
    else
      render action: 'comment'
    end
  end

  private
  def load_blog
    @blog = Blog.find(params[:blog_id] || params[:id])
  end
end
