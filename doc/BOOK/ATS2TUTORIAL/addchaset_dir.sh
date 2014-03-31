#!/bin/sh

CHARSET=$1
INDIR=$2
OUTDIR=$3

mkdir -p $OUTDIR

for i in `find $INDIR -type f`
do
    sed -e s/\^\>\<META\$/\>\<META\\nCHARSET=\"$CHARSET\"\>\<META/ < $i > $OUTDIR/`basename $i`
done
