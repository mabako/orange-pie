class TopicsController < ApplicationController
  before_filter :load_forum

  def show
    @topic = Topic.find(params[:id])
    @comments = @topic.comments
  end

  def new
    authorize! :create_topic, @forum
    @topic = @forum.topics.new
  end

  def create
    authorize! :create_topic, @forum
    @topic = @forum.topics.new(params[:topic])
    @topic.user = current_user
    Topic.transaction do
      begin
        @topic.save!
        
        # add a comment
        comment = @topic.comments.new
        comment.user = @topic.user
        comment.text = @topic.text
        comment.commentable = @topic
        comment.save!

        redirect_to [@forum, @topic]
      rescue
        render action: 'new'
      end
    end
  end

  private
  def load_forum
    @forum = Forum.find(params[:forum_id])
    authorize! :read, @forum
  end
end
