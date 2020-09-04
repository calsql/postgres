#!/bin/sh

echo 'If numactl --hardware results in multiple memory segments,'
echo 'you should recommend setting kernel parameter zone_reclaim_mode'
echo 'to 0.  K. Grittner recommended this in an email conversation'
echo 'with J. Graber on 2014-09-04'
echo
numactl --hardware