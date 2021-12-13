#!/bin/sh

PLINK="/public/home/software/opt/bio/software/plink/1.9/bin/plink"

LDREF="LDREF"

# THIS IS USED TO RESTRICT INPUT SNPS TO REFERENCE IDS ONLY

PRE=$1
PRE_GENO="ga"

PRE_GEXP="expression/egene_exp_$PRE.txt"


# GENERATE ID FILE
cat $PRE_GEXP | head -n1 | tr '\t' '\n' | tail -n+5 | awk '{ print $1,$1 }' > $PRE.sample.ID # 从第五行开始取值




# --- BEGIN SCRIPT:

mkdir locus_plink_bed_$PRE


# Loop through each gene expression phenotype in the batch
cat $PRE_GEXP | awk 'NR > 1' |  while read PARAM; do

# Get the gene positions +/- 500kb
CHR=`echo $PARAM | awk '{ print $2 }'`
P0=`echo $PARAM | awk '{ p=$3 - 0.5e6; if(p<0) p=0; print p; }'`
P1=`echo $PARAM | awk '{ print $4 + 0.5e6 }'`
GNAME=`echo $PARAM | awk '{ print $1 }'`

OUT="locus_plink_bed_$PRE/$GNAME"

echo $GNAME $CHR $P0 $P1

# Pull out the current gene expression phenotype
echo $PARAM | tr ' ' '\n' | tail -n+5 | paste $PRE.sample.ID - > $OUT.pheno

$PLINK --bfile $LDREF/$PRE_GENO.$CHR --pheno $OUT.pheno --make-bed --out $OUT --keep $OUT.pheno --chr $CHR --from-bp $P0 --to-bp $P1 --allow-no-sex

done