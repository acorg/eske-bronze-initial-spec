#!/bin/bash -e

. $HOME/.virtualenvs/35/bin/activate
. ../common.sh

task=$1
log=$logDir/$task.log
fastq=../02-map/$task-unmapped.fastq.gz
out=$task.json.bz2

echo "03-diamond on task $task started at `date`" >> $log
echo "  fastq file is $fastq" >> $log


dbfile=$HOME/scratch/root/share/ncbi/diamond-dbs/viral-protein.dmnd

if [ ! -f $dbfile ]
then
    echo "DIAMOND database file $dbfile does not exist!" >> $log
    exit 1
fi

function skip()
{
    # Make it look like we ran and produced no output.
    echo "  Creating no-results output file due to skipping." >> $log
    cat header.json | bzip2 > $out
}

function run_diamond()
{
    echo "  DIAMOND blastx started at `date`" >> $log
    diamond blastx \
        --tmpdir /ramdisks \
        --threads 24 \
        --query $fastq \
        --db $dbfile \
        --outfmt 6 qtitle stitle bitscore evalue qframe qseq qstart qend sseq sstart send slen btop |
    convert-diamond-to-json.py | bzip2 > $out
    echo "  DIAMOND blastx stopped at `date`" >> $log
}


if [ $SP_SIMULATE = "0" ]
then
    echo "  This is not a simulation." >> $log
    if [ $SP_SKIP = "1" ]
    then
        echo "  DIAMOND is being skipped on this run." >> $log
        skip
    elif [ -f $out ]
    then
        if [ $SP_FORCE = "1" ]
        then
            echo "  Pre-existing output file $out exists, but --force was used. Overwriting." >> $log
            run_diamond
        else
            echo "  Will not overwrite pre-existing output file $out. Use --force to make me." >> $log
        fi
    else
        echo "  Pre-existing output file $out does not exist. Mapping." >> $log
        run_diamond
    fi
else
    echo "  This is a simulation." >> $log
fi

echo "03-diamond on task $task stopped at `date`" >> $log
echo >> $log
