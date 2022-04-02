## plink





>   --allow-no-sex   : Do not treat ambiguous-sex samples as having missing
>                      phenotypes in analysis commands.  (Automatic /w --no-sex.)
>
> 
>

这个参数到底是啥意思？








提取位点

```bash
	plink --bfile genotype/plink/merge_filter --extract final_allTrait_snp.txt --make-bed --out final_allTrait_snp
```





1. vcf转plink格式

The [--make-bed](https://zzz.bwh.harvard.edu/plink/data.shtml#bed) option does the same as --recode but creates binary files; these can also be filtered, etc, as described below.plink 使用说明

- plink 一旦用了`--make-bed` minor就在前面了（A1）
- vcf转plink的时候，不加`--make-bed`，ref当成A2 #plink 

```shell
# 加--make-bed
module load plink/1.9
plink --vcf filter2_Q1000_SNPs_joint_376_MAF0.05.vcf.gz  --out filter2_Q1000_SNPs_joint_376_MAF0.05 --allow-no-sex --allow-extra-chr --make-bed

# 不加--make-bed感觉不太好，因为后面在用plink做分析的话，都还是得加--make-bed之类的，否则可能没有输出
plink --vcf filter2_Q600_SNPs_joint_216_addID.vcf.gz --out filter2_Q600_SNPs_joint_216_addID --allow-no-sex --allow-extra-chr
```



2. 计算频率

plink计算频率的时候，24号染色体都是NA

~/ga/tensorQTL/Genotypes

```sh
module load plink/1.9
plink --bfile filter2_Q600_SNPs_joint_216_addID --freq --out plink_freq_stat --allow-extra-chr
```



3. 转数字格式

--recodeA (Deprecated)。以后用--recode A

https://app.yinxiang.com/shard/s65/nl/17152587/2feecdad-39f2-4086-a73b-cae48e8c5683/

```shell
module load plink/1.9
plink --bfile filter2_Q1000_SNPs_joint_376_MAF0.05 --recodeA --out filter2_Q1000_SNPs_joint_376_MAF0.05
```



4. 提取染色体

--make-bed 或者 --recode。否则就报错

```shell
plink --bfile fHBAU_Q1000_SNP001 --out fHBAU_Q1000_SNP001.1 --allow-no-sex --allow-extra-chr --chr 1 --make-bed
```

### ref

各种参数
https://www.cog-genomics.org/plink/1.9/index

