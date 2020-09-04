#!/bin/bash

# Combining this information with the determined location of
# the cluster's data files makes it possible to determine if
# 4096 kB should be recommended.

for file in $(ls /sys/block/*/queue/read_ahead_kb); do
	echo $file
	cat $file
	echo
done
