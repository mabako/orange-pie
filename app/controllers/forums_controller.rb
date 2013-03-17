class ForumsController < ApplicationController
  def index
    authorize! :read, Forum
    @forums = Forum.roots
  end

  def show
    @forum = Forum.find(params[:id])
    authorize! :read, @forum
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
      # find the forum with that id
      to_update = forums.select{ |f| f.id == info[:id].to_i }.first
      logger.info to_update
      if to_update
        # save the new parent
        to_update.parent = parent
        to_update.save!
        logger.info "  #{to_update.id} #{to_update.parent_id}" 
        # update all children to have the just-updated forum as parent
        unless info[:children].nil?
          update_parents info[:children], forums, to_update
        end
      end
    end
  end
end
