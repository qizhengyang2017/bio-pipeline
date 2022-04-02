module load HTSlib/1.9

# nan换成NaN
sed 's/=nan\([;\t]\)/=NaN\1/g' output-joint_new.vcf|bgzip > output-joint_new_fixed.vcf.gz
tabix output-joint_new_fixed.vcf.gz

# 筛选SNP
module load GATK/4.1.9.0
time gatk SelectVariants \
    -select-type SNP \
    -V output-joint_new_fixed.vcf.gz \
    -O output-joint_new_fixed.snps.vcf.gz

# 为SNP作硬过滤
time gatk VariantFiltration \
    -V output-joint_new_fixed.snps.vcf.gz \
    --filter-expression "QD < 2.0 || MQ < 40.0 || FS > 60.0 || SOR > 3.0 || MQRankSum < -12.5 || ReadPosRankSum < -8.0" \
    --filter-name "Filter" \
    -O hard_filtering_new_fixed.snps.vcf.gz


# 提取
zcat hard_filtering_new_fixed.snps.vcf.gz|awk -F '\t' '{if($0~/^#/)print;else if($7=="PASS")print}' |bgzip > hardFilter.snps.vcf.gz
tabix hardFilter.snps.vcf.gz


module load VCFtools/0.1.16
vcftools --gzvcf hardFilter.snps.vcf.gz --max-missing 0.8 --maf 0.05 --min-alleles 2 --max-alleles 2 --recode --out ma_1081_hardFilter

## 压缩
bgzip output-joint_new.vcf
tabix output-joint_new.vcf.gz