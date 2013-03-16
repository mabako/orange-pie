class Forum < ActiveRecord::Base
  has_ancestry :orphan_strategy => :restrict

  attr_accessible :name

  # fancy urls
  def to_param
    "#{id}-#{name.parameterize}"
  end
end
