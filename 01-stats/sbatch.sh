#!/bin/bash -e

. ../common.sh

task=$1
log=$logDir/sbatch.log

echo "01-stats sbatch.sh running at `date`" >> $log
echo "  task is $task" >> $log
echo "  dependencies are $SP_DEPENDENCY_ARG" >> $log

jobid=`sbatch -n 1 $SP_DEPENDENCY_ARG submit.sh $task | cut -f4 -d' '`
echo "TASK: $task $jobid"

echo "  job id is $jobid" >> $log
echo >> $log