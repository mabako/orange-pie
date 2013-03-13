class User < ActiveRecord::Base
  has_secure_password

  attr_accessible :name, :email, :password, :password_confirmation, :as => :create

  validates :name, :length => { :minimum => 3 }, :uniqueness => { :case_sensitive => false }
  validates :email, :uniqueness => { :case_sensitive => false }, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create }
  validates :password, :presence => true, :length => { :minimum => 8 }, :on => :create
end
