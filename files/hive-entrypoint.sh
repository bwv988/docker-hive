#!/bin/bash

# Configure Hadoop cluster settings.
source /entrypoints/inject_hadoop_cfg.sh

# FIXME: This is not a good solution.
source /entrypoints/service_wait.sh

if [ "$1" = '' ]; then
    echo -e "\nCreating FS structure in HDFS...\n"

    hadoop fs -mkdir       /tmp
    hadoop fs -chmod g+w   /tmp
    hadoop fs -mkdir -p    /user/hive/warehouse
    hadoop fs -chmod g+w   /user/hive/warehouse
    
    echo -e "\nStarting HiveServer2...\n"

    cd $HIVE_HOME/bin
    ./hiveserver2 --hiveconf hive.server2.enable.doAs=false
fi

exec "$@"
