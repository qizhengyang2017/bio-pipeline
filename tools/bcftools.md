`merge`命令也是用于合并VCF文件，主要用于将单个样本的VCF文件合并成一个多个样本的VCF文件。用法如下

```
module load BCFtools/1.8
bcftools merge merge.a.vcf.gz merge.b.vcf.gz -o merge.vcf
```

该命令要求输入文件必须是经过`bgzip`压缩的文件， 而且还需要有`.tbi`的索引。vcf文件需要有表头

2022-03-24：表头要怎样才行？ 能同时merge多个文件吗

INFO FORMAT里的信息，表头中必须要有

```
##fileformat=VCFv4.2
##FORMAT=<ID=GT,Number=1,Type=String,Description="Genotype">
#CHROM  POS     ID      REF     ALT     QUAL    FILTER  INFO    FORMAT  GH0086  GH0087
```



```bash
#替换表头
bcftools reheader -h header_sample.txt new.headerfilter2_Q600_SNPs_joint_216_MAF0.05_common.recode.vcf -o addHeader_filter2_Q600_SNPs_joint_216_MAF0.05_common.recode.vcf
```

