#!/bin/bash -e

. ../common.sh

log=$logDir/sbatch.log

echo "07-error sbatch.sh running at `date`" >> $log
echo "  Dependencies are $SP_DEPENDENCY_ARG" >> $log

jobid=`sbatch -n 1 $SP_DEPENDENCY_ARG --kill-on-invalid-dep=yes submit.sh "$@" | cut -f4 -d' '`
echo "TASK: stop $jobid"

echo "  Job id is $jobid" >> $log
echo >> $log
