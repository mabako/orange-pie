class Blog < ActiveRecord::Base
  belongs_to :user
  attr_accessible :text, :title

  validates :title, :presence => true
  validates :text, :presence => true
  validates :user, :presence => true
end