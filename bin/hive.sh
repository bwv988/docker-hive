#!/bin/bash
# Launch Hive CLI.

docker run -it --rm --net dockercompose_default analytics/hadoop-hive hive
