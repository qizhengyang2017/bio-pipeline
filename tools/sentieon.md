chrome 书签中的帮助文档





https://support.sentieon.com/manual/appendix/troubleshooting/

https://support.sentieon.com/manual/DNAseq_usage/dnaseq/



<img src="/Users/zhengyangqi/Downloads/sentieon.png" alt="sentieon" style="zoom:30%;float:left" />



我的脚本没有没有做BQSR

Base quality score recalibration (BQSR)



BQSR我可能做不了，因为需要另外的文件`KNOWN_DBSNP="$FASTA_DIR/dbsnp_138.b37.vcf.gz"`







官方的joint call脚本比我多一步Base recalibration，call的时候有这个参数`-q recal_data.table`

对应图中的Recalibration table

https://github.com/Sentieon/sentieon-scripts/blob/master/example_pipelines/germline/joint-calling.sh



`--emit_conf=30 --call_conf=30`这两个参数有默认值的，在我的脚本中没写。/Users/zhengyangqi/Documents/lab_report/bio-pipeline/scripts/snp_calling_sampleName_02.sh



印象笔记记录：https://app.yinxiang.com/shard/s65/nl/17152587/c3fe8e64-0b09-4e66-a169-d8da14650af6/





> Since the GATK 4.1 `-newQual` is default genotyping model.

-newQual对应--genotype_model multinomial，所以我也加这个参数好了。





查看帮助

```bash
sentieon driver -h algo Haplotyper
```

