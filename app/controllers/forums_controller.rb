class ForumsController < ApplicationController
  def index
    @forums = Forum.roots
  end
end
