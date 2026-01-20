FROM alpine/jmeter:5.6.3

USER root

RUN apk add --no-cache \
    curl \
    unzip \
    ca-certificates \
    bash

RUN apk del openjdk8-jre
RUN apk add --no-cache openjdk21-jre

ENV JAVA_HOME=/usr/lib/jvm/java-21-openjdk
ENV PATH=$JAVA_HOME/bin:$PATH

RUN java -version

RUN mkdir -p /app/results

COPY jmeter/entrypoint.sh /
COPY jmeter/user.properties /opt/apache-jmeter-5.6.3
COPY jmeter/lib/ext/jmeter-plugins-influxdb2-listener-2.8.jar /opt/apache-jmeter-5.6.3/lib/ext/jmeter-plugins-influxdb2-listener-2.8.jar

RUN curl -L https://jmeter-plugins.org/get/ -o /opt/apache-jmeter-5.6.3/lib/ext/jmeter-plugins-manager.jar
RUN java -cp /opt/apache-jmeter-5.6.3/lib/ext/jmeter-plugins-manager.jar \
      org.jmeterplugins.repository.PluginManagerCMDInstaller \
      /opt/apache-jmeter-5.6.3/bin

RUN curl -L https://repo1.maven.org/maven2/kg/apc/cmdrunner/2.3/cmdrunner-2.3.jar \
    -o /opt/apache-jmeter-5.6.3/lib/cmdrunner-2.3.jar

RUN /opt/apache-jmeter-5.6.3/bin/PluginsManagerCMD.sh install jpgc-standard,tilln-junit,jmeter-components,jmeter.pack-listener,jmeter-tcp,jmeter-native,jmeter-mongodb,jmeter-mail,jmeter-ldap,jmeter-java,jmeter-junit,jmeter-jms,jmeter-jdbc,jmeter-http,jmeter-ftp,jpgc-tst,jpgc-perfmon,jmeter-core,bzm-parallel,jpgc-fifo,jpgc-ffw,jpgc-dummy,jpgc-casutg,jpgc-functions

RUN chmod +x /entrypoint.sh

RUN ls /opt/apache-jmeter-5.6.3/lib/ext

WORKDIR /app

ENTRYPOINT ["/entrypoint.sh"]