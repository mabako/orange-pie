class TopicsController < ApplicationController
  before_filter :load_forum
  before_filter :load_topic, :except => [:new, :create]

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

  def show
    @comments = @topic.comments.page params[:page]
    if can? :comment, @topic
      @newcomment = Comment.new
      @newcomment.user = current_user
    end
  end

  def reply
    authorize! :comment, @topic
    @comment = Comment.new(params[:comment])
    @comment.user = current_user
    @comment.commentable = @topic
    if @comment.save
      redirect_to [@forum, @topic], :anchor => "comment-#{@comment.id}"
    end
  end

  private
    def load_forum
      @forum = Forum.find(params[:forum_id])
      authorize! :read, @forum
    end

    def load_topic
      @topic =  @forum.topics.find(params[:id])
    end
end
