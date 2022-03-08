## bedtools

提取序列

```
bedtools getfasta -name -fi ../Ghirsutum_genome.fasta -bed qtl_pos_1.txt -fo uplandCotton_public_QTL.fa
```

merge

```bash
bedtools merge -h

bedtools merge -i alltime_hotspot_sorted.bed  -c 4,5,6 -o collapse,sum,collapse > merge_hotspot_ID.bed


# -d 指定距离
for i in 4 8 12 16 20;do bedtools merge -i ${i}DPA_sorted_hotspot.bed -d 20000 -c 4,6 -o collapse,sum > ${i}DPA_merge_20k.bed;done
```





```shell
module load BEDTools/2.27
#=====================
bedtools groupby -h

# ~/ga/hotspot/hot_scan_newCis/hotspot_all/tracks_c/bedtools_intersect

# 按第1-5列分组，9，11列summarize
bedtools intersect -a 4D_hotspot.bed -b 4D_all.bed -wa -wb |bedtools groupby -g 1-5 -c 9,11 -o collapse|head


#==============
# 查看帮助文档
bedtools intersect -h

bedtools intersect -nonamecheck -a QTL_pos_range.bed -b change.Chr_genome_final_gene_deleteConfig.bed -wa -wb|bedtools groupby -i - -g 1-4 -c 8 -o collapse |les




```



```sh
module load BEDTools/2.27

# 下面两条命令等效

bedtools intersect -a introg_1based.bed -b Ghirsutum_gene_model_Ghir_number_1based_tab.bed -wa -wb|bedtools groupby -i - -g 1-3 -c 7 -o collapse 

bedtools intersect -a introg_1based.bed -b Ghirsutum_gene_model_Ghir_number_1based_tab.bed -wa -wb|bedtools groupby  -c 7 -o collapse > introg_gene_within.txt


```



