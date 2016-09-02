# Dockerfile for Apache Hive.

FROM analytics/hadoop-base

ENV HIVE_VERSION 1.2.1

WORKDIR /opt

ENV HIVE_DL_URL http://ftp.heanet.ie/mirrors/www.apache.org/dist/hive/hive-$HIVE_VERSION/apache-hive-$HIVE_VERSION-bin.tar.gz

RUN wget $HIVE_DL_URL && \
	apt-get update && \
	apt-get install -y --no-install-recommends net-tools libpostgresql-jdbc-java && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* && \
	tar -xzvf apache-hive-$HIVE_VERSION-bin.tar.gz && \
	mv apache-hive-$HIVE_VERSION-bin hive && \
	rm apache-hive-$HIVE_VERSION-bin.tar.gz

ENV HIVE_HOME /opt/hive
ENV PATH $HIVE_HOME/bin:$PATH
ENV HADOOP_HOME /opt/hadoop-$HADOOP_VERSION

COPY files/hive-site.xml $HIVE_HOME/conf
COPY files/beeline-log4j2.properties $HIVE_HOME/conf
COPY files/hive-env.sh $HIVE_HOME/conf
COPY files/hive-exec-log4j2.properties $HIVE_HOME/conf
COPY files/hive-log4j2.properties $HIVE_HOME/conf
COPY files/ivysettings.xml $HIVE_HOME/conf
COPY files/llap-daemon-log4j2.properties $HIVE_HOME/conf

# Link the Postgres JDBC jar.
RUN ln -s /usr/share/java/postgresql-jdbc4.jar $HIVE_HOME/lib/postgresql-jdbc4.jar

COPY files/hive-entrypoint.sh /entrypoints/hive-entrypoint.sh
COPY files/service_wait.sh /entrypoints/service_wait.sh
RUN chmod +x /entrypoints/hive-entrypoint.sh && \
	chmod +x /entrypoints/service_wait.sh

EXPOSE 10000
EXPOSE 10002

ENTRYPOINT ["/entrypoints/hive-entrypoint.sh"]
