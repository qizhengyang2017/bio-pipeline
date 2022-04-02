```bash
ls |grep -v gz|xargs -i mv {} ../..
ls H01_ZTJ|grep -v "RData"|awk '{print "H01_ZTJ/"$0}'|xargs zip -r H01_ZTJ.zip # grep 不要加星号，加了星号不会排除RData。先删除原先的H01_ZTJ.zip，再进行压缩，否则还是原先的文件，只是时间变了
ls *_pseudotime_heatmap.{pdf,png}|xargs rm monocle.RData

#BD比对数据，结果整理命令
ls *png *csv *st |xargs -I {} cp "{}" /data/X101SC19031497-Z01-F023-B10/result/Day3_1/

ls *png *csv *st |xargs -I {} cp "{}" /data/X101SC19031497-Z01-J002-B14/result/TDF_PB_60
ls *png *csv *st |xargs -I {} cp "{}" /data/X101SC19031497-Z01-J002-B14/result/TDF_BM_60

```





~/work_new/ga

mac中的xargs没有-i参数

xargs，把标准输入作为参数。 -I {} 指定参数位置

zotero-19687

```bash
# grep_con条件少可以成功，条件多就成功不了了（比如208个）。也不知道为什么。
cat grep_con|xargs -I {} grep -E {} Orthogroups.tsv
```

grep_con文件如下

```
Garb_01G007110|Garb_01G012740|Garb_01G012770|Garb_01G012970|Garb_01G026730|Garb_01G027170|Garb_01G027840|Garb_01G028840
```

