class Forum < ActiveRecord::Base
  has_many :topics

  # tree structure
  has_ancestry :orphan_strategy => :restrict
  scope :roots, :conditions => { ancestry_column => nil }, :order => 'sort asc'
  def children
    self.base_class.scoped :conditions => child_conditions, :order => 'sort asc'
  end

  attr_accessible :name

  # fancy urls
  def to_param
    "#{id}-#{name.parameterize}"
  end
end
