package me.jsperafico.sap.assignment;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;

import io.qameta.allure.karate.AllureKarate;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;

class ParallelTest {

  @BeforeAll
  static void beforeAll() throws Exception {
    AllureEnvWriter.writeEnv();
  }

  @Test
  void testParallel() {
    Results results = Runner.path("classpath:me/jsperafico/sap/assignment")
        .hook(new AllureKarate())
        .tags("~@ignore")
        .parallel(5);
    assertEquals(0, results.getFailCount(), results.getErrorMessages());
  }
}