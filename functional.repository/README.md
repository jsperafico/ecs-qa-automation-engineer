# Functional Test repository

In order to trigger the test inside a container, please use:


## Run parallel
```sh
mvn clean test -Dkarate.env=local
```

## Run single suite
```sh
mvn clean test -Dkarate.env=local -Dtest=AllTestsRunner#e2e
```