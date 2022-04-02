## grep

-w选项匹配单词（文件中写入`$'\t'`，不匹配tab）



grep -w -f test_con test1

cat test1|grep -w -f test_con (grep也能读取标准输出)

```
#CHROM
1_233

#CHROM
a	1_233	bb
b	1_2333	cc
```





```sh
# 匹配制表符
grep -v $'\t' all.txt
```

```sh
# Linux下grep显示前后几行信息      
 
grep -C 5 foo file  显示file文件里匹配foo字串那行以及上下5行
grep -B 5 foo file  显示foo及前5行
grep -A 5 foo file  显示foo及后5行
 
# 查看版本号
grep -V

```

```sh
# 搜索几百G的大文件，用grep比较快
grep -m 1 -A 3 -n "34319821" output-joint_new.vcf
```



```bash
#使用文件提取
# gene_uniq_2中不能有空行，否则会提取所有的行
grep -f gene_uniq_2.txt change.Chr_genome_final_gene.bed > all_gene.bed

#grep 筛选文件，顺序跟原文件一样，而不是跟筛选条件一样
```



shell从字符串中提取子串 https://www.cnblogs.com/jmliao/p/11808592.html

```sh
# grep 提取版本号。-o选项，可以只打印匹配的部分，否则会打印整行。
echo "libgcc-4.8.5-4.h5.x86_64.rpm" | grep -Eo "[0-9]+\.[0-9]+.*x86_64"

# sed使用\1反向引用前面匹配的组。
echo "libgcc-4.8.5-4.h5.x86_64.rpm" | sed -r "s/libgcc-([0-9]+\.[0-9]+.*)\.rpm/\1/g"
```



```bash
# grep 或
ls | grep -v -E "pn.txt|samplelist|run.sh" |xargs rm -rf
ls|grep -v -E "samplelist|run.sh|pn.txt"|awk '{print "rm -r "$0}'|sh


cat result.csv|grep -E "碱基不均衡|5'文库|3'文库|10xATAC-seq文库" |grep "2020" |awk -F , '{print $15"\t"$20"\t"$13"\t"$5"\t"$3}' > m
awk -F '\t' 'NR==FNR {a[$1]=$5;next} {$4=a[$4]} 1' OFS='\t' t m > mapfile

```



```bash
查找指定文件

grep -Rn 'getChrsRegionsBins.pl' *pbs # 不会搜索下一级目录
grep -n 'getChrsRegionsBins.pl' *pbs # 当前目录


grep --include=\*.pbs -nR . -e 'getChrsRegionsBins.pl' #遍历整个目录
# https://stackoverflow.com/questions/16956810/how-do-i-find-all-files-containing-specific-text-on-linux?page=1&tab=votes#tab-top

real    0m0.833s
user    0m0.009s
sys    0m0.031s



find . -name "*.pbs" | xargs grep -n "getChrsRegionsBins.pl" # 用find更快，但没有文本高亮

real    0m0.015s
user    0m0.007s
sys    0m0.010s

```

