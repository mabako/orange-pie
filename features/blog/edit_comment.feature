Feature: Edit blog comment
  In order to edit a blog comment
  As a user

    Background:
      Given I am logged in
      And the blog entry "cakes!" exists

    Scenario: User edits own blog comment
      Given a comment by "joe" exists
      When I click "Blog"
      When I click "cakes!"
      And I click "Edit" on the comment
      And I fill in "Comment" with "My new updated comment"
      And I press "Save"
      Then I should see a blog comment with "My new updated comment"

    Scenario: User edits own blog comment without text
      Given a comment by "joe" exists
      When I click "Blog"
      When I click "cakes!"
      And I click "Edit" on the comment
      And I fill in "Comment" with ""
      And I press "Save"
      Then the "Comment" field should have the "can't be blank" error
