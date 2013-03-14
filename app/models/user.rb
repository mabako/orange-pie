class User < ActiveRecord::Base
  has_secure_password

  attr_accessible :name, :email, :password, :password_confirmation, :as => :create

  validates :name, :length => { :minimum => 3 }, :uniqueness => { :case_sensitive => false }
  validates :email, :uniqueness => { :case_sensitive => false }, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create }
  validates :password, :presence => true, :length => { :minimum => 8 }, :on => :create

  # returns a fancy url for the users; for example "cat" with id 42 would be 
  # "42-cat", and "Long Long Name" would be "42-long-long-name". i.e. nice urls
  def to_param
    "#{id}-#{name.parameterize}"
  end

  # url for avatars: once it is possible for users to upload custom avatars, it should be checked if they have any and just return that url instead
  private
  def avatar_url size
    "https://vanillicon.com/#{Digest::MD5.hexdigest(email)}_#{size}.png"
  end

  public
  def avatar_small
    avatar_url(50)
  end

  def avatar_large
    avatar_url(100)
  end
end
