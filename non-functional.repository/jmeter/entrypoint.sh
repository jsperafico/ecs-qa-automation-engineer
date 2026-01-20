#!/bin/sh
set -e

freeMem=`awk '/MemFree/ { print int($2/1024) }' /proc/meminfo`
s=$(($freeMem/10*8))
x=$(($freeMem/10*8))
n=$(($freeMem/10*2))
export JVM_ARGS="-Xmn${n}m -Xms${s}m -Xmx${x}m"

echo "START Running Jmeter on `date`"
echo "JVM_ARGS=${JVM_ARGS}"
echo "jmeter args=$@"

jmeter -n -t "/app/TC01-must_succeed_validating_accuracy_of_rate_limiter.jmx" -Jprotocol=http -Jhost=backend -l /app/results/tc01.jtl  -j /app/results/tc01.log -Jjmeter.save.saveservice.autoflush=true -Jjmeterengine.force.system.exit=true 
jmeter -n -t "/app/TC02-must_evaluate_memory_leak.jmx" -Jprotocol=http -Jhost=backend -l /app/results/tc02.jtl -j /app/results/tc02.log -Jjmeter.save.saveservice.autoflush=true -Jjmeterengine.force.system.exit=true 

sed -i 's/name="JUnit Reporter"/name="TC01-must_succeed_validating_accuracy_of_rate_limiter"/' "/app/results/tc01.xml"
sed -i 's/name="JUnit Reporter"/name="TC02-must_evaluate_memory_leak"/' "/app/results/tc02.xml"

echo "END Running Jmeter on `date`"