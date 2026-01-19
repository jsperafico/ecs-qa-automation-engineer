# Functional Test repository

This repository contains both Integration and E2E automated tests.
A local execution of a single test type can be achieved through:

```sh
mvn clean test -Dkarate.env=local -Dtest=AllTestsRunner#e2e -Dapi.timeout=3000
```

or

```sh
mvn clean test -Dkarate.env=local -Dtest=AllTestsRunner#integration -Dapi.timeout=3000
```

Being the best approach to tackle ongoing changes to the Application Under Test.

Nonetheless, real-life situation more ofthen than not, require speed to deliver results.
This can be achieved through the statement below:

```sh
mvn clean test -Dkarate.env=local -Dapi.timeout=3000
```

As mentioned in the Test Strategy, one way to centralized the visualization of test results derivetived from
local execution is Allure Reports. By running locally or through a container, both will generate the minimum
amount of information for a report be rendered in Allure. The current configuration is far from ideal, but
should be able to give a good indication where we are going at. In order to visualize the report, please use:

```sh
mvn allure:serve
```