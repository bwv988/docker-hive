#!/bin/bash
IP=$(ifconfig eth0 | grep 'inet addr' | awk -F: '{print $2}'| awk '{print $1}')
echo -e "\n[HIVE] IP: ${IP}\n\n"

# Configure Hadoop cluster settings.
/hadoop_config.sh

# FIXME: This is not a good solution.
/service_wait.sh

if [ "$1" = '' ]; then
    echo -e "\nCreating FS structure in HDFS...\n"

    hadoop fs -mkdir -p    /user/hive/warehouse
    hadoop fs -chmod g+w   /user/hive/warehouse

    echo -e "\nStarting HiveServer2...\n"

    cd $HIVE_HOME/bin
    ./hiveserver2 --hiveconf hive.server2.enable.doAs=false
fi

exec "$@"