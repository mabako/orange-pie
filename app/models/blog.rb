class Blog < ActiveRecord::Base
  paginates_per 3 # blog posts on the /blog page

  belongs_to :user
  has_many :comments, :as => :commentable

  scope :sorted, order('created_at desc, id desc')

  attr_accessible :text, :title

  validates :title, :presence => true
  validates :text, :presence => true
  validates :user, :presence => true

  has_formatted :text

  # nicer urls
  def to_param
    "#{id}-#{title.parameterize}"
  end
end
