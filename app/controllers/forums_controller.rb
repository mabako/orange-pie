class ForumsController < ApplicationController
  def index
    authorize! :read, Forum
    @forums = Forum.roots
  end

  def show
    @forum = Forum.find(params[:id])
    authorize! :read, @forum
  end
end
