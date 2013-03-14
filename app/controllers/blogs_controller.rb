class BlogsController < ApplicationController
  def index
    authorize! :read, Blog
    @blogs = Blog.all
  end

  def show
    @blog = Blog.find(params[:id])
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
    @blog = Blog.find(params[:id])
    authorize! :update, @blog
  end

  def update
    @blog = Blog.find(params[:id])
    authorize! :update, @blog

    respond_to do |format|
      if @blog.update_attributes(params[:blog])
        format.html { redirect_to @blog, notice: 'Blog was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blogs/1
  # DELETE /blogs/1.json
  def destroy
    @blog = Blog.find(params[:id])
    authorize! :destroy, @blog
    @blog.destroy

    respond_to do |format|
      format.html { redirect_to blogs_url }
      format.json { head :no_content }
    end
  end
end
