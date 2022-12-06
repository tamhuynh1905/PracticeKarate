Feature: Create token
  Scenario: Create token
    Given url baseUri
    #Given url 'https://api.realworld.io/api'
    And path '/users/login'
    And request {"user":{"email":"#(userEmail)","password":"#(userPassword)"}}
    #And request {"user":{"email":"#(email)","password":"#(password)"}}
    #And request {"user":{"email":"tamhuynh8689@fakegmail.com","password":"Kms@2019"}}
    When method Post
    Then status 200
    * def authToken = response.user.token