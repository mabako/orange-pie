class Topic < ActiveRecord::Base
  belongs_to :user
  belongs_to :forum
  has_many :comments, :as => :commentable

  attr_accessible :title

  validates :title, :presence => true
  validates :user, :presence => true
  validates :forum, :presence => true

  # fancy url
  def to_param
    "#{id}-#{title.parameterize}"
  end
end
