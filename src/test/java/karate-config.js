function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    baseUri: 'https://api.realworld.io/api'
//    myVarName: 'someValue'
  }
  if (env == 'dev') {
    config.userEmail = 'tamhuynh8689@fakegmail.com'
    config.userPassword = 'Kms@2019'
    // e.g. config.foo = 'bar';
  }
  else if (env == 'qa') {
    config.userEmail = 'tamhuynh5194@fakegmail.com'
    config.userPassword = 'Kms@2019'
  }

  var token = karate.callSingle('classpath:helpers/CreateToken.feature', config).authToken
  karate.configure("headers", {Authorization: 'Token ' + token})

  return config;
}