function fn() {
  var env = karate.env
  var baseUrl = karate.properties['baseUrl']

  karate.log('karate.env system property was:', env)
  karate.log('karate.baseUrl system property was:', baseUrl)

  if (!env) {
    env = 'dev'
  }

  var config = {
    env: env,
    baseUrl: baseUrl
  }

  if (!baseUrl) {
    if (env == 'local') {
      config.baseUrl = 'http://localhost:3000'
    } else if (env == 'dev') {
      config.baseUrl = 'https://dev.logging.sap'
    } else if (env == 'e2e') {
      config.baseUrl = 'https://e2e.logging.sap'
    }
  }

  return config
}