## vcftools

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
```



joint calling之后的过滤流程

```bash
module load VCFtools/0.1.16
module load HTSlib/1.9

# 提取SNP
vcftools --vcf output-joint.vcf --remove-indels --recode --recode-INFO-all --out du_A2_228
```





## 其他


```bash
# 有问题，只得到123,100个SNP
# minQ应该是指的第五列QUAL；~/Tutorial
# 是不是minGO太高了
# https://vcftools.github.io/man_latest.html
# --minQ 30 --minDP 3。位点作missing处理
vcftools --vcf du_A2_228.recode.vcf --max-missing 0.8 --maf 0.05 --minQ 30 --minDP 3 --minGQ 20 --min-alleles 2 --max-alleles 2 --recode --stdout|bgzip > du_A2_228_filter.vcf.gz
tabix du_A2_228_filter.vcf.gz
```



测试vcftools --minQ 命令

```bash
# date: 2022-03-03
# path: ~/my_tutorial
# desc: 测试vcftools --minQ 命令

zcat raw.vcf.gz|awk '$0!~/^##/' |head -n 5|cut -f1-12 > raw_test.vcf

# 去掉info
vcftools --vcf raw_test.vcf --recode --out raw_test

vcftools --vcf raw_test.recode.vcf --minQ 30 --recode --out minQ30_raw_test
```



