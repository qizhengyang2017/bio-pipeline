表型文件也是plink格式，FID IID

表型值中不能有NA

/data/cotton/zyqi/ma_2021_ng_vcf/join/filter

```sh
cat phenotype_1.txt|awk '{print $1,$2,$3,$4}' OFS='\t'|grep -v NA > phenotype_2.txt
```







```sh
module load Fastlmm/v0.2.32
bsub -J FS -o FS_%J.out -e FS_%J.err -q q2680v2 -n 5 "
fastlmmc -bfile plink/ma_1081 -bfilesim plink/ma_1081 -pheno phenotype_2.txt  -mpheno 2 -out FS_Num2_out
"
```

