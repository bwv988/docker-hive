#!/bin/bash
# Launch Beeline CLI.
echo -e "HiveServer2 connect string: \n"
echo -e "!connect jdbc:hive2://hive:10000 hiveuser hiveuser\n"

docker run -it --rm --net dockercompose_default bwv988/hadoop-hive beeline
