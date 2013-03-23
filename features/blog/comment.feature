Feature: Edit blog comment
  In order to edit a blog comment
  As a user

    Background:
      Given I am logged in
      And the blog entry "cakes!" exists

    Scenario: User adds new comment
      When I visit the blog
      When I click "cakes!"
      And I fill in "Comment" with "Hey ho"
      And I press "Add Comment"
      Then I should see the newest blog comment with "Hey ho"

    Scenario: User adds new comment without text
      Given a comment by "joe" exists
      When I visit the blog
      When I click "cakes!"
      And I fill in "Comment" with ""
      And I press "Add Comment"
      Then the "Comment" field should have the "can't be blank" error

      When I fill in "Comment" with "now with more of less useful things"
      And I press "Add Comment"
      Then I should see the newest blog comment with "now with more of less useful things"
