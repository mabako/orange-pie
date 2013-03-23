Then(/^the "(.*?)" field should have the "(.*?)" error$/) do |field_label, error_message|
  within('form #error_explanation ul') do
    page.should have_content("#{field_label} #{error_message}")
  end
end

When(/^I fill in "(.*?)" with "(.*?)"$/) do |field_name, value|
  fill_in field_name, :with => value
end
