class TopicsController < ApplicationController
  before_filter :load_forum

  def show
  end

  def new
    authorize! :create_topic, @forum
    @topic = @forum.topics.new
  end

  def create
    authorize! :create_topic, @forum
    @topic = @forum.topics.new(params[:topic])
    @topic.user = current_user
    if @topic.save
      redirect_to @forum
    else
      render action: 'new'
    end
  end

  private
  def load_forum
    @forum = Forum.find(params[:forum_id])
    authorize! :read, @forum
  end
end
