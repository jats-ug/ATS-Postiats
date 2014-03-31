#!/bin/sh

FROMCODE=$1
TOCODE=$2
INDIR=$3
OUTDIR=$4

mkdir -p $OUTDIR

for i in `find $INDIR -type f`
do
    iconv -f $FROMCODE -t $TOCODE -o $OUTDIR/`basename $i` $i
done
