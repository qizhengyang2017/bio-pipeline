## sed
```sh
# 多个匹配
sed  's/rawdata\///;s/_R1.fq.gz//' sample_line_count.txt > sample_line_count_1.txt

#sed 行首加字符
sed -i '1s/^/Gene\t&/g' merge_df.txt


cut -d " " -f 1,7- uplandMagic_number1.txt |sed '2,12d'  >  genotype_number.txt


sed '1d;s/,/\t/g' clusters.csv > clusters.txt


sed -i 's/^gene://g' Bos_taurus_bta_kegg.txt


删除行首有NA的行
sed -i '/^NA/d' Bos_taurus_bta_kegg.txt

# sed 打印 5~10 行内容。-n安静模式
sed -n '5,10p' test.txt

#插入行子命令i
#将文件中1-2行上边都添加一行内容A
sed '1,2i A'


# 连续替换
for i in `ls`;do sed -i '1 s/Feature ID/Gene ID/;1 s/Feature Name/Gene_name/' $i;done
```

