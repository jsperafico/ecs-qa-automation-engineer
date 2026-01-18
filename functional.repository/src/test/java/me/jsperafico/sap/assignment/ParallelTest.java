package me.jsperafico.sap.assignment;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;

class ParallelTest {

  @Test
  void testParallel() {
    Results results = Runner.path("classpath:me/jsperafico/sap/assignment")
        .tags("~@ignore")
        .parallel(5);
    assertEquals(0, results.getFailCount(), results.getErrorMessages());
  }
}