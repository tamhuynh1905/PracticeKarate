Feature: Article
  Background: Define URL
    Given url baseUri
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * def randomArticle = dataGenerator.getRandomArticle()
    * def randomDeletedArticle = dataGenerator.getRandomArticle()
#    * def resToken = callonce read('classpath:helpers/CreateToken.feature')
#    * def token = resToken.authToken

#    Given url 'https://api.realworld.io/api'
#    And path '/users/login'
#    And request {"user":{"email":"tamhuynh8689@fakegmail.com","password":"Kms@2019"}}
#    When method Post
#    Then status 200
#    * def token = response.user.token
  #* def resToken = callonce read('classpath:helpers/CreateToken.feature') {"email":"tamhuynh8689@fakegmail.com","password":"Kms@2019"}
  #* def resToken = callonce read('classpath:helpers/CreateToken.feature')
  #* def resToken = call read('classpath:helpers/CreateToken.feature')

  Scenario: Create a new article
    Given path 'articles'
#    And header Authorization = 'Token ' + token
    And request {"article": {"tagList": [],"title": "#(randomArticle)","description": "description for #(randomArticle)","body": "body for #(randomArticle)"}}
    When method Post
    Then status 200
    And match response.article.title == '#(randomArticle)'


  Scenario: Create and delete an article
    Given path 'articles'
    And request {"article": {"tagList": [],"title": "#(randomDeletedArticle)","description": "description for Deleted_article001","body": "body for Deleted_article001"}}
    When method Post
    Then status 200
    And match response.article.title == '#(randomDeletedArticle)'
    * def articleId = response.article.slug

    Given path 'articles'
    And params '{limit: 10, offset: 0}'
    When method Get
    Then status 200
    And match response.articles[0].title == "#(randomDeletedArticle)"

    Given path 'articles',articleId
    When method Delete
    Then status 204

    And path 'articles'
    And params '{limit: 10, offset: 0}'
    When method Get
    Then status 200
    And match response.articles[0].title != '#(randomDeletedArticle)'