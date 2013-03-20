class Topic < ActiveRecord::Base
  belongs_to :user
  belongs_to :forum
  has_many :comments, :as => :commentable

  attr_accessible :title

  # virtual attribute text for creating comments
  attr_accessor :text
  attr_accessible :text

  validates :title, :presence => true
  validates :user, :presence => true
  validates :forum, :presence => true
  validates :text, :presence => { :on => :create }

  # fancy url
  def to_param
    "#{id}-#{title.parameterize}"
  end
end
