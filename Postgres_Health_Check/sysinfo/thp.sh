#!/bin/bash

echo 'transparent_hugepage/enabled' `cat /sys/kernel/mm/transparent_hugepage/enabled`
echo 'transparent_hugepage/defrag' `cat /sys/kernel/mm/transparent_hugepage/defrag`
