#!/bin/bash

# See Thom's AHC manual for instructions regarding when
# to recommend the 'noop' setting over the default 'cfq'

for file in $(ls /sys/block/*/queue/scheduler); do
	echo $file
	cat $file
	echo
done
