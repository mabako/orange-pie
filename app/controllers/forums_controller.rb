class ForumsController < ApplicationController
  def index
    authorize! :read, Forum
    @forums = Forum.roots
  end

  def show
    @forum = Forum.find(params[:id])
    authorize! :read, @forum
    @topics = @forum.topics.sorted.page params[:page]
  end

  def manage
    authorize! :manage, Forum
    @forums = Forum.roots
  end

  # saves the new forum order
  def managed
    authorize! :manage, Forum
    Forum.transaction do
      forums = Forum.all
      logger.info params[:forums]

      # set the new parents
      update_parents params[:forums], forums, nil

      # raise an exception if the data is bullshit
      logger.info 'Checking the integrity'
      Forum.check_ancestry_integrity!
    end

    # don't need no response here
    head :ok
  end

  private
  # updates the forums to match the new parent-ids
  #   updated: parameters for the individual forums to set, may have children to call recursively
  #   forums: list of all forums
  #   parent: new parent to set
  def update_parents updated, forums, parent
    updated.each_with_index do |forum, index|
      info = forum[1]
      if info[:id].to_i < 0
        # new forum!
        to_update = Forum.new({:name => info[:name]})
      else
        # find the forum with that id
        to_update = forums.select{ |f| f.id == info[:id].to_i }.first
      end
      if to_update
        to_update.sort = index + 1
        to_update.category = info[:category] == 'true'

        # save the new parent
        to_update.parent = parent
        to_update.save!

        # update all children to have the just-updated forum as parent
        unless info[:children].nil?
          update_parents info[:children], forums, to_update
        end
      end
    end
  end
end
