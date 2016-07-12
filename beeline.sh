#!/bin/bash
# Launch Hive CLI.
# Note: This is deprecated.

DATA_VOL=data

docker run -it --net=host -v $DATA_VOL:/hive-metastore bwv988/hadoop-hive hive
