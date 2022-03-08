#====2022年02月24日========

module load BCFtools/1.8
module load HTSlib/1.9
module load VCFtools/0.1.16

# 去掉contig上的SNP
zcat filter2_Q600_SNPs_joint_216_MAF0.05.vcf.gz|awk '{if (/^#|^Chr/) print}'|sed '1i ##fileformat=VCFv4.2' > we_216.vcf

# 替换表头
bcftools reheader -h header_sample.txt we_216.vcf -o addHeader_we_216.vcf

# bgzip
bgzip addHeader_we_216.vcf
tabix addHeader_we_216.vcf.gz


# merge
bcftools merge du_A2_228_Q400_filter.vcf.gz addHeader_we_216.vcf.gz -o merge.vcf

# 染色体变数字
cat merge.vcf| sed 's/^Chr[0]*//' > merge_number.vcf

# bgzip
bgzip merge_number.vcf
tabix merge_number.vcf.gz

# 过滤
vcftools --gzvcf merge_number.vcf.gz --max-missing 0.4 --maf 0.05 --min-alleles 2 --max-alleles 2 --recode --stdout|bgzip > merge_number_filter.vcf.gz

zcat  merge_number_filter.vcf.gz|grep -v '^#'|wc -l > snp_number.txt


zcat merge_number_filter.vcf.gz|awk '{if(/^#/){print}else{$3=$1"_"$2;print}}' OFS='\t'|bgzip > merge_number_filter_addID.vcf.gz


plink --vcf merge_number_filter_addID.vcf.gz --out merge_number_filter_addID --allow-no-sex --allow-extra-chr --make-bed
plink --bfile merge_number_filter_addID --indep-pairwise 1000kb 1 0.05 --out ld --allow-extra-chr
cat ld.prune.in|awk -F_ '{print $1"\t"$2}' > position.txt

vcftools --gzvcf merge_number_filter_addID.vcf.gz --positions position.txt --recode --out clean_ld

bgzip clean_ld.recode.vcf

#利用tassel软件对文件进行排序
run_pipeline.pl -Xmx30G -SortGenotypeFilePlugin -inputFile clean_ld.recode.vcf.gz \
    -outputFile clean_ld_sorted.recode.vcf.gz -fileType VCF

#vcf文件格式转换成Phylip格式，用于后续构建进化树
run_pipeline.pl  -Xmx30G -importGuess clean_ld_sorted.recode.vcf.gz  \
    -ExportPlugin -saveAs supergene.phy -format Phylip_Inter

module load FastTree/2.1.11
FastTree supergene.phy  >  fasttree.nwk

Rscript ape_plot.r fasttree.nwk fasttree.pdf



#=========2022年02月25日===============
# ~/ga/A2_public_QTL

# 把dir1中的数据删除之后，在用rsync，dir2下载到一半的文件还会存在吗？
# 答案是还会存在的

rsync -avP ~/ga/raw_data /data/cotton/zyqi/Ga


# bedtools提取序列
bedtools getfasta -name -fi test.fa -bed p.bed -fo out.fa

# 转成bed格式，从0开始，前开后闭。染色体重新命名
cat A2_QTL_li2022a_position.txt|awk 'NR>1{print $4,$5-1,$6,$1}' OFS='\t' | awk '{if($1<=9){$1="Chr0"$1;print}else{$1="Chr"$1;print}}' OFS='\t' > A2_QTL_li2022a_position.bed



module load BEDTools/2.27
bedtools getfasta -name -fi G.arboreum.fa -bed A2_QTL_li2022a_position.bed -fo A2_QTL.fa


## blast比对
module load BLAST+/2.10.1
makeblastdb -in Lachesis_assembly_changed.fa -dbtype nucl -out Lachesis_assembly_changed

blastn -db Lachesis_assembly_changed -query A2_QTL.fa -num_threads 2 -outfmt 7 -out A2_QTL_one2one_blast




## 取最近marker的区间。侧翼的区间太长了
cat A2_QTL_nearest_marker.txt|awk 'NR>1{print $4,$5-1,$6,$1}' OFS='\t'|awk '{if($1<=9){$1="Chr0"$1;print}else{$1="Chr"$1;print}}' OFS='\t' > A2_QTL_nearest_marker.bed

module load BEDTools/2.27
bedtools getfasta -name -fi ../G.arboreum.fa -bed A2_QTL_nearest_marker.bed -fo A2_QTL_nearest_marker.fa

module load BLAST+/2.10.1

blastn -db ../our_gemone/Lachesis_assembly_changed -query A2_QTL_nearest_marker.fa -num_threads 2 -outfmt 7 -out A2_QTL_nearest_marker_blast

# Fields: query acc.ver, subject acc.ver, % identity, alignment length, mismatches, gap opens, q. start, q. end, s. start, s. end, evalue, bit score

cat A2_QTL_nearest_marker_blast|awk '{if(!/^#/){print}else{if($4>100){print}}}' OFS='\t' > A2_QTL_nearest_marker_blast_length100

# ~/ga/A2_public_QTL/nearest_marker

awk '!a[$1,$2]++' A2_QTL_nearest_marker_blast > A2_QTL_nearest_marker_blast_top




## li tree

bgzip random5.imputed.new.vcf

#利用tassel软件对文件进行排序
run_pipeline.pl -Xmx30G -SortGenotypeFilePlugin -inputFile random5.imputed.new.vcf.gz \
    -outputFile clean_ld_sorted.recode.vcf.gz -fileType VCF

#vcf文件格式转换成Phylip格式，用于后续构建进化树
run_pipeline.pl  -Xmx30G -importGuess clean_ld_sorted.recode.vcf.gz  \
    -ExportPlugin -saveAs supergene.phy -format Phylip_Inter

module load FastTree/2.1.11
FastTree supergene.phy  >  fasttree.nwk

Rscript ape_plot.r fasttree.nwk fasttree.pdf


###----------

### get clean data
# /data/cotton/zyqi/Ga/A2_216

module load fastp/0.23.0

module load SAMtools/1.9

# input
basedir=/data/cotton/zyqi/Ga/A2_216
mkdir report_02 clean_data_02

cat $basedir/sample_02 |while read i
do

fq1_raw=$basedir/upload/${i}_R1.fq.gz
fq2_raw=$basedir/upload/${i}_R2.fq.gz

fq1=$basedir/clean_data_02/${i}_1.clean.fq.gz
fq2=$basedir/clean_data_02/${i}_2.clean.fq.gz

report=$basedir/report_02/$i.html
json=$basedir/report_02/$i.json


# thread
nt=2


# queue
bsub -J ${i} -o %J.${i}.out -e %J.${i}.err -n $nt -q q2680v2 "

# get clean data

fastp -w $nt -i $fq1_raw -I $fq2_raw -o $fq1 -O $fq2 -h $report -j $json

"
done


# J51_1.clean.fq.gz






screen -S test #新建一个叫test的会话
# ctrl a d

screen -ls # 会话的 ID 以及名字

screen -r test #重新连接到已分离的 Screen 会话

# 要关闭 Screen 会话很简单，就和关闭平常的会话一样，你可以使用 Ctrl d 快捷键，也可以输入 exit 命令关闭

bsub -q interactive -Is bash

module load fastp/0.23.0
fastp -w 2 -i upload/J153_R1.fq.gz -I upload/J153_R2.fq.gz -o clean_data/J153_1.clean.fq.gz -O clean_data/J153_2.clean.fq.gz -h report/J153.html -j report/J153.json

# 原因是
# mkdir: cannot create directory ‘clean_data_test’: Disk quota exceeded

# ln: 无法创建硬链接"./J104_R1.fq.gz" => "/data/cotton/zyqi/Ga/A2_216/J104_R1.fq.gz": 无效的跨设备连接

split -d -l 80 sample_name.txt sample_