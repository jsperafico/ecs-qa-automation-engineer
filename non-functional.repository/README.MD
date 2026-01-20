# Non-Functional Test repository

This repository contains two performance tests. The technology stack used is:

- JMeter 5.6.3
- InfluxDB 2.x
- Grafana latest
- NPM latest
- Allure 2

As can be seen, the usage of InfluxDB goes totally agains what is specified in the [Test Strategy](../docs/test-strategy.md), there being PostgreSQL. This is due time constraints. The amount of overhead required just to create a Listenner responsible to sent statistics over PostgreSQL on a simple assessment, it is simply not worth it.

InfluxDB - at the time of being written - presents several short commings, such as:

- Not optimum for high density test results composed of 1M+ response samples
- Provides new connections every release. Flux was introduced in version 2, now SQL is being introduced in version 3. Makes hard to predict what will be maintained, since original query language is to be deprecated.

Nonetheless, this InfluxDB connector for JMeter is what the open-source community has made available. Works just fine for this assessment.

When it comes to writing the test cases, I have chosen to use the Application Under Test as is. Meaning, nothing was changed in the configuration to make the application runs more efficiently.

So, we reach the part where Rate limit is set at [index.js line:28](../logging-backend/index.js)

Having a rate limit of 100 requests/min that automatically rejects incomming requests once quota was reached, unables to properly evaluate the overall metrics, regardless of how many pod/containers:

- Real bottlenecks in the infrastructure
- Tail latency under load
- Latency and throughput become meaningless

If, by any chance, the rate limit was established per request ***and***:

1. based on production metrics obtained by [Honeycomb](https://www.honeycomb.io/)
2. the application under test is a brand new app without any prior history of execution.

Then it would be possible to provide meaningful insights on how well the application runs.

## Visualize Allure results

The NPM project seen here, is simply to facilitate running allure locally. In order to visualize the test results, please use:

```sh
npm run allure
```

There you will see the KPIs defined in the Test Strategy.

## Grafana visualization for CI/CD execution

The dashbord accessible through [Grafana Url](http://localhost:5000/d/b4kP_KoMzasadasdasd123) depicts a default visualization of test statistics. Every request and response is stored in InfluxDB to later on be post-processed and presented on Grafana.

This opens a window of possibilities, like integration with Environment Under Test statics collected through Prometheus aiming to identify performance downfalls.

![Grafana Results](../docs/images/grafana-performance-example.png)