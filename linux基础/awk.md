## awk

awk染色体字母转数字

```sh
cat Samples_Q1000_SNPs_joint_376.filter1.vcf|awk 'NR==1{print}NR>1{if(/^Ghir_A/){a=$1;gsub(/Ghir_A0*/,"",a);$3=a"_"$2;print}else if(/^Ghir_D/){b=$1;gsub(/Ghir_D0*/,"",b);b=b+13;$3=b"_"$2;print}}' OFS='\t' > Samples_Q1000_SNPs_joint_376.filter1_addID.vcf
```



合并有表头的文件

```sh
awk 'FNR==1 && NR!=1{next;}{print}' *.txt > final_merge_bin.txt
```



awk去重

```sh
cat test.txt|awk '!x[$0]++'

# 按第一行第二行去重
awk '!a[$1,$2]++' input_file
```

awk指定多个分隔符
```sh
zcat independent/8DPA.cis_independent_qtl.txt.gz|awk 'NR>1 && $17!=1{print $7,$17}'|awk -F'[ _]' '{print $1,$2,$3}'
```

awk前几列

```sh
head -n 10 test.txt|awk '{NF=9}1' OFS="\t"
```

awk 条件

```sh
awk '{if(/^#/){print $0}else{if($6>3000){print $0}}}' ma_1081_Q1000_rmMAFMissing_biallilic.recode.vcf > ma_1081_Q3000_rmMAFMissing_biallilic.recode.vcf

# 也可以用分号
zcat hard_filtering_new_fixed.snps.vcf.gz|awk -F '\t' '{if($0~/^#/)print;else if($7=="PASS")print}'|bgzip > hardFilter.snps.vcf.gz
```



awk匹配

```shell
awk 'NR==FNR{a[$4]=$1"\t"$2"\t"$3;next}{b=a[$2];print b,$2,$1}' OFS='\t' change.Chr_genome_final_gene_1based.bed QTL_gene.txt > QTL_gene_pos.txt

awk '$1 ~ /-4$|-5$|-6$/{print $0}' FS='\t' clusters.txt > group2.txt

awk 'NR==1{print $0};NR>1 && $5<0.05{print $0}' Cluster_1.xls|les

awk -F, 'BEGIN{print "Barcode,Cluster,Group"}NR>1 && $1 ~ "-1" || $1 ~ "-2"|| $1 ~ "-3"||$1 ~ "-1" || $1 ~ "-2"|| $1 ~ "-5"{print $0",group1"}' test # 加group
```



```bash
awk -F, 'BEGIN{print "Barcode,Cluster,Group"}{if (NR>1 && $1 ~ "-1" || $1 ~ "-2"|| $1 ~ "-3"){print $0",group1"} else {print $0",group2"}}' test
Barcode,Cluster,Group
Barcode,Cluster,group2
AAACCCACATCCGGTG-1,8,group1
AAACCCAGTAGGCAGT-2,6,group1
AAAGGATAGGTCTTTG-3,1,group1
AAAGGATTCGCCTTTG-4,3,group2
AAAGGGCTCTGTAAGC-5,1,group2


awk -F, '{if (NR==1){print $0",Group"} else if (NR>1 && $1 ~ "-1" || $1 ~ "-2"|| $1 ~ "-3"){print $0",group1"} else {print $0",group2"}}' test
Barcode,Cluster,Group
AAACCCACATCCGGTG-1,8,group1
AAACCCAGTAGGCAGT-2,6,group1
AAAGGATAGGTCTTTG-3,1,group1
AAAGGATTCGCCTTTG-4,3,group2
AAAGGGCTCTGTAAGC-5,1,group2
```



```bash
#awk 字符串拼接
cat test.txt|awk '{if(NR%2==1){print}else{a=substr($1,1,9);b=substr($1,22,9);c=substr($1,44,9);print (a""b""c)}}'

# 截取
zcat TDF_PB_10_14-1_S1_L002_R1_001.fastq.gz TDF_PB_10_14-2_S1_L003_R1_001.fastq.gz |gzip > TDF_PB_10_14_1.fq.gz
gzip -dc TDF_PB_10_14_1.fq.gz |awk '{if(NR%2==1){print}else{print substr($1,0,75)}}' |gzip  >TDF_PB_10_14_S1_L001_R1_001.fastq.gz
```



使用外部变量

```sh
for i in `ls  -d Cluster_[0-9]*`;do grep -i -E 'signal transduction|glucose related pathway|cell death|oxidative phosphorylation|lipid metablism|amino acid metablism' $i/${i}_KEGGenrich.txt | awk -v n=$i 'BEGIN{FS=OFS="\t"}{print n,$1,$2,$3,$4,$5,$6}' > ${i}_KEGGenrich.txt; done
# -d, –directory 将目录象文件一样显示，而不是显示其下的文件。
```

