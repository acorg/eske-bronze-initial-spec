# IMPORTANT: All paths in this file are relative to the scripts in
# 00-start, etc. This file is sourced by those scripts.

dataDir=../../../..
logDir=../logs
doneFile=../slurm-pipeline.done
runningFile=../slurm-pipeline.running
errorFile=../slurm-pipeline.error
statsDir=$dataDir/stats
rsToSample=$dataDir/rs-to-sample

function sampleName()
{
    # The sample name is the basename of our parent directory.
    echo $(basename $(dirname $(/bin/pwd)))
}
