
When(/^I press "(.*?)"$/) do |button_name|
  click_button button_name
end

When(/^I click "(.*?)"$/) do |link_name|
  click_link link_name
end

Then(/^I should see the header "(.*?)"$/) do |text|
  within('.content-header h1') do
    page.should have_content text
  end
end

Then(/^I should see "(.*?)"$/) do |text|
  page.should have_content text
end
