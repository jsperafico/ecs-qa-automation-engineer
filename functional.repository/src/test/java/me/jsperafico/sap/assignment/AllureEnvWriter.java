package me.jsperafico.sap.assignment;

import java.io.File;
import java.io.FileOutputStream;
import java.util.Properties;

public class AllureEnvWriter {

  public static void writeEnv() throws Exception {
    File allureResultsDir = new File("target/allure-results");
    if (!allureResultsDir.exists()) {
      allureResultsDir.mkdirs();
    }

    File envFile = new File(allureResultsDir, "environment.properties");

    Properties props = new Properties();
    props.setProperty("Environment", System.getProperty("karate.env", "local"));
    props.setProperty("BaseURL", System.getProperty("baseUrl", "http://localhost:3000"));
    props.setProperty("Test Type", "Integration");

    try (FileOutputStream fos = new FileOutputStream(envFile)) {
      props.store(fos, "Allure Environment Properties");
    }
  }
}
