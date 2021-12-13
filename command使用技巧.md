```shell
find . -name "independent*"
```


awk指定多个分隔符
```shell
zcat independent/8DPA.cis_independent_qtl.txt.gz|awk 'NR>1 && $17!=1{print $7,$17}'|awk -F'[ _]' '{print $1,$2,$3}'|les
```


## shell 的循环操作
```sh
# read -a: Each name is an indexed array variable (see Arrays above).
cat QTL_select_14.txt|while read -a NAME
do
echo ${NAME[2]}
done
```

## 多个匹配模式
```shell
sed  's/rawdata\///;s/_R1.fq.gz//' sample_line_count.txt > sample_line_count_1.txt

#sed 行首加字符
sed -i '1s/^/Gene\t&/g' merge_df.txt

```

