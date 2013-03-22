def create_visitor
  @visitor ||= { :name => 'joe', :email => 'joe@example.org', :password => 'hello world!', :password_confirmation => 'hello world!' }
end

def find_user
  @user ||= User.where(:email => @visitor[:email]).first
end

def create_user
  create_visitor
  @user = FactoryGirl.create(:user, @visitor)
end

def sign_up
  visit '/signup'
  fill_in 'user_name', :with => @visitor[:name]
  fill_in 'user_email', :with => @visitor[:email]
  fill_in 'user_password', :with => @visitor[:password]
  fill_in 'user_password_confirmation', :with => @visitor[:password_confirmation]
  click_button 'Sign Up'
  find_user
end

Given(/^I am not logged in$/) do
  page.driver.delete('/logout')
end

When(/^I sign up with valid user data$/) do
  create_visitor
  sign_up
end

When(/^I sign up without a name$/) do
  create_visitor
  @visitor.merge!(:name => '')
  sign_up
end

When(/^I sign up with a too short name$/) do
  create_visitor
  @visitor.merge!(:name => 'as')
  sign_up
end

When(/^I sign up with an invalid email$/) do
  create_visitor
  @visitor.merge!(:email => 'notquitevalid')
  sign_up
end

Given(/^a user with the same name exists$/) do
  create_user
  @visitor.merge!(:email => 'something@example.com')
  sign_up
end

When(/^I sign up without filling the password field$/) do
  create_visitor
  @visitor.merge!(:password => '', :password_confirmation => '')
  sign_up
end

Then(/^I should see a successful sign up message$/) do
  page.should have_content 'Welcome aboard!'
end

Then(/^I should not see a blank message$/) do
  page.should_not have_content 'blank'
end
