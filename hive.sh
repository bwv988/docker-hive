#!/bin/bash
# Launch Beeline CLI.

DATA_VOL=data

docker run -it --net=host -v $DATA_VOL:/hive-metastore bwv988/hadoop-hive beeline
