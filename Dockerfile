# Dockerfile for Apache Hive.

FROM bwv988/hadoop-base

ENV HIVE_VERSION 1.2.2

WORKDIR /opt

ENV HIVE_DL_URL=http://ftp.heanet.ie/mirrors/www.apache.org/dist/hive/hive-$HIVE_VERSION/apache-hive-$HIVE_VERSION-bin.tar.gz
ENV HIVE_HOME=/opt/hive
ENV PATH=$HIVE_HOME/bin:$PATH
ENV HADOOP_HOME=/opt/hadoop-$HADOOP_VERSION

COPY files/hive-entrypoint.sh files/service_wait.sh /entrypoints/

RUN wget $HIVE_DL_URL \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends net-tools libpostgresql-jdbc-java \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* \
	&& tar -xzvf apache-hive-$HIVE_VERSION-bin.tar.gz \
	&& mv apache-hive-$HIVE_VERSION-bin hive \
	&& rm apache-hive-$HIVE_VERSION-bin.tar.gz \
	&& ln -s /usr/share/java/postgresql-jdbc4.jar $HIVE_HOME/lib/postgresql-jdbc4.jar \
	&& chmod +x /entrypoints/hive-entrypoint.sh \
	&& chmod +x /entrypoints/service_wait.sh

COPY files/hive-site.xml files/beeline-log4j2.properties \
		 files/hive-env.sh files/hive-exec-log4j2.properties \
		 files/hive-log4j2.properties files/ivysettings.xml \
		 files/llap-daemon-log4j2.properties $HIVE_HOME/conf/


EXPOSE 10000
EXPOSE 10002

ENTRYPOINT ["/entrypoints/hive-entrypoint.sh"]
