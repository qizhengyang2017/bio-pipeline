# Description: du228份亚洲棉call SNP
# date: 2022年02月18日
# /data/cotton/yqzhang/zyqi/Ga_du_228


module load sentieon/201808.07
module load SAMtools/1.9

# input
basedir=/data/cotton/yqzhang/zyqi/Ga_du_228
mkdir SNP_call


cat $basedir/sample_00 |while read i
do

fq1=$basedir/data/${i}_1.clean.fq.gz
fq2=$basedir/data/${i}_2.clean.fq.gz

fasta=/data/cotton/zyqi/genome/Lachesis_assembly_changed.fa

# output dir
workdir=$basedir/SNP_call/$i

# thread
nt=10

platform="ILLUMINA"
mq=30
[ ! -d $workdir ] && mkdir -p $workdir
cd $workdir
# rm *bam
rawCram=$i.cram
sortedCram=$i.q$mq.sorted.cram
depCram=$i.deduped.cram
realnCram=$i.realn.cram
outvcf=$i.vcf


# queue
bsub -J ${i} -o %J.${i}.out -e %J.${i}.err -n $nt -q q2680v2 "


# ********************************************calling **************************************
exec > $workdir/$i.callVCF.log 2>&1

# 1. 利用 BWA-MEM 进行比对并排序

(sentieon bwa mem -M -R '@RG\tID:${i}\tSM:${i}\tPL:$platform' \
-t $nt -K 10000000 $fasta $fq1 $fq2 || echo -n 'error' )| samtools sort -@ $nt  --output-fmt CRAM \
--reference $fasta -o $rawCram - && samtools index -@ $nt $rawCram

samtools view -hCS -T $fasta -q $mq -o $sortedCram $rawCram && \
samtools index -@ $nt $sortedCram

samtools flagstat $rawCram > $i.stat.raw.txt && \
samtools flagstat $sortedCram > $i.stat.q$mq.txt &


# 2. Calculate data metrics

sentieon driver -r $fasta -t $nt -i $sortedCram --algo MeanQualityByCycle ${i}_mq_metrics.txt \
--algo QualDistribution ${i}_qd_metrics.txt --algo GCBias --summary ${i}_gc_summary.txt ${i}_gc_metrics.txt \
--algo AlignmentStat --adapter_seq '' ${i}_aln_metrics.txt --algo InsertSizeMetricAlgo ${i}_is_metrics.txt

sentieon plot metrics -o ${i}_metrics-report.pdf gc=${i}_gc_metrics.txt \
qd=${i}_qd_metrics.txt mq=${i}_mq_metrics.txt isize=${i}_is_metrics.txt

sentieon driver -r $fasta -t $nt -i $sortedCram --algo LocusCollector --fun score_info ${i}_score.txt

# 3. 去除 Duplicate Reads

sentieon driver -r $fasta -t $nt -i $sortedCram --algo Dedup --rmdup --cram_write_options version=3.0 \
--score_info ${i}_score.txt --metrics ${i}_dedup_metrics.txt $depCram && rm $sortedCram

# 4. Variant calling

sentieon driver -r $fasta -t $nt -i $depCram --algo Haplotyper --emit_mode gvcf ${i}.gvcf && rm $depCram

sentieon util vcfconvert ${i}.gvcf ${i}.gvcf.gz && rm ${i}.gvcf && rm $rawCram && rm $fq1 $fq2

"
done


