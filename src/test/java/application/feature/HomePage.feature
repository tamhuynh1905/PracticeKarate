
Feature: Test for the home page
  Background: precondition
    Given url baseUri

  Scenario: Get all tags
    Given path 'tags'
    When method Get
    Then status 200
    And match response.tags contains ["implementations", "welcome"]
    And match response.tags !contains 'coding'
    And match response.tags == '#array'
    And match each response.tags == '#string'
    And match response.tags contains any ["implementations", "welcome"]
#    And match response.tags contains only ["implementations", "welcome"]


  Scenario: Get all articles
    * def isTimeValidation = read('classpath:helpers/TimeValidation.js')
    Given path 'articles'
    Given params '{limit: 10, offset: 0}'
    When method Get
    Then status 200
    And match response.articles == '#[10]'
#    And match response.articlesCount == 172
#    And match response == {"articles": "#array", "articlesCount": "172" }
#    And match response.articles[0].createAt contains 2022
#    And match response.articles[*].favouritesCount contains 0
    And match each response..bio == '##string'
    And match each response.articles ==
    """
    {
            "slug": "#string",
            "title": "#string",
            "description": "#string",
            "body": "#string",
            "tagList": "#array",
            "createdAt": "#? isTimeValidation(_)",
            "updatedAt": "#? isTimeValidation(_)",
            "favorited": '#boolean',
            "favoritesCount": '#number',
            "author": {
                "username": "#string",
                "bio": ##string,
                "image": "#string",
                "following": '#boolean'
            }
        }
    """

#  Scenario: Get all tags
#    Given url 'https://api.realworld.io/api'
#    Given path 'tags'
#    When method Get
#    Then status 200

#    @debug
#  Scenario: Get all articles
#    Given url 'https://api.realworld.io/api'
#    Given path 'articles'
#    Given param limit = 10
#    Given param offset = 0
#    When method Get
#    Then status 200