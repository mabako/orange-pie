class Blog < ActiveRecord::Base
  belongs_to :user
  has_many :comments, :as => :commentable

  scope :sorted, order('created_at desc')

  attr_accessible :text, :title

  validates :title, :presence => true
  validates :text, :presence => true
  validates :user, :presence => true

  # nicer urls
  def to_param
    "#{id}-#{title.parameterize}"
  end
end
