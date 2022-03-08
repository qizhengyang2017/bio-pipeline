`merge`命令也是用于合并VCF文件，主要用于将单个样本的VCF文件合并成一个多个样本的VCF文件。用法如下

```
module load BCFtools/1.8
bcftools merge merge.a.vcf.gz merge.b.vcf.gz -o merge.vcf
```

该命令要求输入文件必须是经过`bgzip`压缩的文件， 而且还需要有`.tbi`的索引。vcf文件需要有表头



```bash
#替换表头
bcftools reheader -h header_sample.txt new.headerfilter2_Q600_SNPs_joint_216_MAF0.05_common.recode.vcf -o addHeader_filter2_Q600_SNPs_joint_216_MAF0.05_common.recode.vcf
```

