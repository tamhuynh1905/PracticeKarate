@ignore
Feature: Signup account

  Background: precondition
    Given url baseUri
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * def randomEmail = dataGenerator.getRandomEmail()
    * def randomUsername = dataGenerator.getRandomUsername()


  Scenario: New user
    Given path 'users'
    And request
    """
    {
      "user": {
        "email": "#(randomEmail)",
        "password": "Kms@2019",
        "username": "#(randomUsername)"
      }
    }
    """
    When method Post
    Then status 200
    And match response ==
    """
    {
    "user": {
        "email": "#string",
        "username": "#string",
        "bio": ##string,
        "image": ##string,
        "token": "#string"
    }
}
    """

  @ignore
  Scenario Outline: New user
    Given path 'users'
    And request
    """
    {
      "user": {
        "email": "<email>",
        "password": "Kms@2019",
        "username": "<username>"
      }
    }
    """
    When method Post
    Then status 422
    And match response == <errorResponse>

    Examples:
      | email             | password  | username          | errorResponse                                      |
      | #(randomEmail)    | Karate123 | tamhuynh          | {"errors":{"username":["has already been taken"]}}
      | tamhuynh@test.com | Karate123 | #(randomUsername) | {"errors":{"email":["has already been taken"]}}
      |                   | Karate123 | #(randomUsername) | {"errors":{"email":["can't be blank"]}}
      | #(randomEmail)    | Karate123 |                   | {"errors":{"username":["can't be blank"]}}
      | #(randomEmail)    |           | #(randomUsername) | {"errors":{"password":["can't be blank"]}}

# "email": "#('Test'+userData.email)",
#    * def userData = {"email": "tamhuynh12346@gmail.com","username": "tamhuynh12346"}
#    And request {"user": {"email": "#('Test'+userData.email)","password": "Kms@2019","username": "#('Test'+userData.username)"}}