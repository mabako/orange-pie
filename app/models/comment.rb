class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :commentable, :polymorphic => true
  attr_accessible :text

  validates :user, :presence => true
  validates :text, :presence => true
  validates :commentable, :presence => true
end
