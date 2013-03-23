Feature: blog post pagination
  In order to see more than just the default three blog posts
  As a visitor
  I want to be able to switch between blog pages

    Background:
      # reverse order when showing
      Given the blog entry "one" exists
      And the blog entry "two" exists
      And the blog entry "three" exists
      And the blog entry "four" exists
      And the blog entry "five" exists
      And I visit the blog

    Scenario: View first page
      Then I should see "three"
      And I should see "four"
      And I should see "five"
      And I should not see "one"
      And I should not see "two"

    Scenario: Switch to next page
      Then I should see "Next ›"
      When I click "Next ›"
      Then I should see "one"
      And I should see "two"
      And I should not see "three"
      And I should not see "four"
      And I should not see "five"
