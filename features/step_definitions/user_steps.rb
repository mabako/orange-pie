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

def delete_user
  @user ||= User.where(:email => @visitor[:email]).first
  @user.destroy unless @user.nil?
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

Given(/^I am logged in$/) do
  create_user
  visit '/login'
  fill_in 'name', :with => @visitor[:name]
  fill_in 'password', :with => @visitor[:password]
  click_button 'Login'
  page.should_not have_content 'Login'
  page.should have_content 'Logout'
end

Given(/^I am logged in as admin$/) do
  @user = FactoryGirl.create(:admin, { :password => 'thispassword', :password_confirmation => 'thispassword' })
  visit '/login'
  fill_in 'name', :with => @user[:name]
  fill_in 'password', :with => 'thispassword'
  click_button 'Login'
  page.should_not have_content 'Login'
  page.should have_content 'Logout'
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

Given(/^I do not exist as user$/) do
  create_visitor
  delete_user
end

Given(/^I do exist as user$/) do
  create_user
end

When(/^I go to the log in page$/) do
  visit '/login'
end

Then(/^I should see an invalid login message$/) do
  page.should have_content 'Could not log you in'
end

Then(/^I should see a successful login message$/) do
  page.should have_content 'Hi there'
end

Then(/^I should be logged out$/) do
  page.should have_content 'Login'
  page.should_not have_content 'Logout'
end

Then(/^I should be logged in$/) do
  page.should_not have_content 'Login'
  page.should have_content 'Logout'
end
