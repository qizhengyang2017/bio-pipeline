# date: 2022-week09
# SNP calling，做进化树。鉴定品种


# 出错的材料重新call
# /public/home/yqzhang/zyqi/A2_216/SNP_call_remain/J20

# 报错

bsub -q normal -o %J.out -e %J.err "
module load sentieon/201808.07
sentieon util vcfconvert J39.gvcf J39.gvcf.gz
"

可以用bgzip, tabix 替代 sentieon util vcfconvert





# joint calling
# /public/home/yqzhang/zyqi/A2_216
# 参考 /data/cotton/zyqi/ma_2021_ng_vcf/join/archive



# 接hard_filtering_tree.sh，不需要用gatk提取SNP

module load HTSlib/1.9

# nan换成NaN
sed 's/=nan\([;\t]\)/=NaN\1/g' me_A2_216.recode.vcf|bgzip > output-joint_new_fixed.vcf.gz
tabix output-joint_new_fixed.vcf.gz

module load GATK/4.1.9.0
# 为SNP作硬过滤
time gatk VariantFiltration \
    -V output-joint_new_fixed.vcf.gz \
    --filter-expression "QD < 2.0 || MQ < 40.0 || FS > 60.0 || SOR > 3.0 || MQRankSum < -12.5 || ReadPosRankSum < -8.0" \
    --filter-name "Filter" \
    -O hard_filtering_new_fixed.snps.vcf.gz

# 提取

zcat hard_filtering_new_fixed.snps.vcf.gz|awk -F '\t' '{if($0~/^#/)print;else if($7=="PASS")print}' |bgzip > hardFilter.snps.vcf.gz
tabix hardFilter.snps.vcf.gz


module load VCFtools/0.1.16
vcftools --gzvcf hardFilter.snps.vcf.gz --max-missing 0.8 --maf 0.05 --min-alleles 2 --max-alleles 2 --recode --out hardFilter.snps.final


# 随机提取SNP
cat hardFilter.snps.final.recode.vcf|awk '$0!~/^#/'|shuf -n 50000 > random_SNP.vcf

# header我是打印在终端上复制的
cat header.txt random_SNP.vcf > random_SNP_header.vcf




# 2022-03-05
# /public/home/yqzhang/zyqi/A2_216
# 50000 -> 37371
vcftools --vcf random_SNP_header.vcf --recode --recode-INFO-all --stdout --maf 0.05 --max-missing 0.7 --minDP 4 --maxDP 1000 --minQ 30 --minGQ 0 --min-alleles 2 --max-alleles 2 --remove-indels |bgzip > clean.vcf.gz



#试一下不过滤
# 接hard_filtering_tree_2.sh


module load HTSlib/1.9
module load VCFtools/0.1.16


cat hardFilter.snps.final.recode.vcf|awk '$0!~/^#/'|shuf -n 200000 > random_SNP.vcf

cat header.txt random_SNP.vcf > random_SNP_header.vcf


#利用tassel软件对文件进行排序
run_pipeline.pl -Xmx30G -SortGenotypeFilePlugin -inputFile random_SNP_header.vcf \
    -outputFile random_SNP_header_sorted.vcf.gz -fileType VCF

#vcf文件格式转换成Phylip格式，用于后续构建进化树
run_pipeline.pl  -Xmx30G -importGuess random_SNP_header_sorted.vcf.gz  \
    -ExportPlugin -saveAs supergene.phy -format Phylip_Inter

module load FastTree/2.1.11
FastTree supergene.phy  >  fasttree.nwk

Rscript ape_plot.r fasttree.nwk fasttree_nofilter.pdf




# 2022-03-06
# /public/home/yqzhang/zyqi/A2_216



# 再增加标记数量


cat hardFilter.snps.final.recode.vcf|awk '$0!~/^#/'|shuf -n 1500000 > random_SNP.vcf

cat header.txt random_SNP.vcf > random_SNP_header.vcf


#利用tassel软件对文件进行排序
run_pipeline.pl -Xmx30G -SortGenotypeFilePlugin -inputFile random_SNP_header.vcf \
    -outputFile random_SNP_header_sorted.vcf.gz -fileType VCF

#vcf文件格式转换成Phylip格式，用于后续构建进化树
run_pipeline.pl  -Xmx30G -importGuess random_SNP_header_sorted.vcf.gz  \
    -ExportPlugin -saveAs supergene.phy -format Phylip_Inter

module load FastTree/2.1.11
FastTree supergene.phy  >  fasttree.nwk

Rscript ape_plot.r fasttree.nwk fasttree_nofilter_1.5M.pdf


# /public/home/yqzhang/zyqi/A2_216/500k
# /public/home/yqzhang/zyqi/A2_216/all


# 聚类的效果和标记的数量有很大的关系。







# 2022-03-07
# /public/home/yqzhang/zyqi/A2_216/200k/raxml-ng
# RAxML

conda install -c bioconda raxml-ng

#参考 @zotero-18784
# 构建核苷酸树（模型GTR，1000次自检值抽样）
raxml-ng --all --msa random_SNP_header.min4.phy --model GTR --prefix T15 --threads 15  --bs-trees 1000






# /public/home/yqzhang/zyqi/A2_216/200k
# iqtree
# iqtree似乎不用管是核苷酸还是蛋白序列

# 直接运行，有示例代码
iqtree

# 参考 @cjchen
iqtree -s random_SNP_header.min4.phy -m MFP -bb 1000  -bnni -cmax 15  -redo -nt AUTO




# /public/home/yqzhang/zyqi/A2_216/200k/fasttree

# 查看帮助文档
FastTree

# IUPAC nucleotide code
# https://www.bioinformatics.org/sms/iupac.html

# vcf转成fasta。也会自动生成phy格式的文件
# FastTree accepts alignments in fasta or phylip interleaved formats
# 用下面这个脚本转的是PHYLIP non-interleaved (sequential) format。
# http://bioinformatics.psb.ugent.be/downloads/psb/Userman/treecon_intro.html

# 需要指定参数是核酸序列！


python vcf2phylip.py -i random_SNP_header.vcf -f


module load FastTree/2.1.11
FastTree -nt random_SNP_header.min4.fasta  >  fasttree.nwk
Rscript ../../ape_plot.r fasttree.nwk fasttree_nofilter_nt_200k.pdf

