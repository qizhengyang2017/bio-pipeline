## vcftools

https://vcftools.github.io/man_latest.html

```sh
# 提取样本
module load VCFtools/0.1.16
vcftools --gzvcf 372A.SNP.raw.vcf.gz --keep sample_name.txt --recode --recode-INFO-all --out du_A2

# 提取SNP
vcftools --gzvcf clean.vcf.gz --positions position.txt --recode --out clean_ld

# 过滤
vcftools --vcf du_A2_228.recode.vcf --max-missing 0.8 --maf 0.05 --min-alleles 2 --max-alleles 2 --recode --out du_A2_228_filter

# 求两个vcf文件相同的SNP
vcftools --gzvcf du_A2_228_filter.recode.vcf.gz --gzdiff filter2_Q600_SNPs_joint_216_MAF0.05.vcf.gz --diff-site --out du_v_my

# 计算频率
# ~/ga/tensorQTL/Genotypes
module load VCFtools/0.1.16
vcftools --gzvcf filter2_Q600_SNPs_joint_216_number.vcf.gz --freq --out freq_analysis


# 基因型数字格式
module load VCFtools/0.1.16
vcftools --gzvcf ../base_data/filter2_Q1000_SNPs_joint_376_MAF0.05_number_id.vcf.gz --positions clump_snp_positions.txt --012 --out base_clump_snp
```



joint calling之后的过滤流程

```bash
module load VCFtools/0.1.16
module load HTSlib/1.9

# 提取SNP
vcftools --vcf output-joint.vcf --remove-indels --recode --recode-INFO-all --out du_A2_228
```



黄越凡过滤脚本

```bash
vcftools --gzvcf 2021NG_DU.vcf.gz --remove-indels --max-missing 0.8 --maf 0.05 --minQ 1000 --recode --recode-INFO-all --out 2021NG_DU_Q1000_0.05
java -Xss10m -jar $EBROOTBEAGLE/beagle.jar gt=2021NG_DU_Q1000_0.05.recode.vcf  out=2021NG_DU_Q1000_0.05.beagle.vcf
```



## 其他



测试vcftools --minQ 命令。结论就是这个参数的说明。只保留质量值在阈值以上的位点。

```bash
# date: 2022-03-03
# path: ~/my_tutorial
# desc: 测试vcftools --minQ 命令

zcat raw.vcf.gz|awk '$0!~/^##/' |head -n 5|cut -f1-12 > raw_test.vcf

# 去掉info
vcftools --vcf raw_test.vcf --recode --out raw_test

vcftools --vcf raw_test.recode.vcf --minQ 30 --recode --out minQ30_raw_test
```



**--minQ** *<float>*

Includes only sites with Quality value above this threshold.



**--minDP** *<float>*
**--maxDP** *<float>*

Includes only genotypes greater than or equal to the "--minDP" value and less than or equal to the "--maxDP" value. This option requires that the "DP" FORMAT tag is specified for all sites.

These options are used to exclude genotypes from any analysis being performed by the program. If excluded, these values will be treated as missing.
