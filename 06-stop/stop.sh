#!/bin/bash -e

. $HOME/.virtualenvs/35/bin/activate
. ../common.sh

log=$logDir/slurm-pipeline.log

echo "SLURM pipeline finished at `date`" >> $log

touch $doneFile
