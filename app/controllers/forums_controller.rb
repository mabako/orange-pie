class ForumsController < ApplicationController
  def index
    @forums = Forum.roots
  end

  def show
    @forum = Forum.find(params[:id])
  end
end
