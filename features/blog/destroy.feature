Feature: Delete a blog entry
  In order to delete a new blog entry
  As a admin

    Background:
      Given I am logged in as admin
      And the blog entry "orangey" exists
      And I visit the blog
      And I click "orangey"

    Scenario: Delete blog entry
      When I click "Delete"
      Then I should see the header "Blog"
      And I should not see "orangey"
