When(/^I visit the blog$/) do
  visit '/blog'
end

Given(/^the blog entry "(.*?)" exists$/) do |title|
  @admin ||= FactoryGirl.create(:admin)
  @blog ||= FactoryGirl.create(:blog, {:title => title, :user => @admin})
  if @blog.title != title
    @blog = Blog.find_by_title(title)
    if @blog.nil?
      @blog = FactoryGirl.create(:blog, {:title => title, :user => @admin})
    end
  end
end

Given(/^a comment by "(.*?)" exists/) do |name|
  @comment ||= Comment.new({:text => 'lorem ipsum'})
  @comment.commentable = @blog
  @comment.user = User.find_by_name(name)
  @comment.save
end

When(/^I go to the blog entry "(.*?)"$/) do |arg1|
  visit @blog
end

When(/^I click "(.*?)" on the comment$/) do |arg1|
  within("#comment-#{@comment.id} .pie") do
    click_link 'Edit'
  end
end

Then(/^I should see a blog comment with "(.*?)"$/) do |text|
  within("#comment-#{@comment.id} .ninja") do
    page.should have_content text
  end
end

Then(/^I should see the newest blog comment with "(.*?)"$/) do |text|
  @lastcomment = Comment.last
  within("#comment-#{@lastcomment.id} .ninja") do
    page.should have_content text
  end
end
