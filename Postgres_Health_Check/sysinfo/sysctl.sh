#!/bin/bash

/sbin/sysctl kernel.shmmax
/sbin/sysctl kernel.shmall
/sbin/sysctl vm.dirty_bytes
/sbin/sysctl vm.dirty_background_bytes
/sbin/sysctl vm.dirty_ratio
/sbin/sysctl vm.dirty_background_ratio
/sbin/sysctl vm.overcommit_memory
/sbin/sysctl vm.swappiness
/sbin/sysctl vm.zone_reclaim_mode
