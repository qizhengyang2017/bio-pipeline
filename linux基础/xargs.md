```bash
ls |grep -v gz|xargs -i mv {} ../..
ls H01_ZTJ|grep -v "RData"|awk '{print "H01_ZTJ/"$0}'|xargs zip -r H01_ZTJ.zip # grep 不要加星号，加了星号不会排除RData。先删除原先的H01_ZTJ.zip，再进行压缩，否则还是原先的文件，只是时间变了
ls *_pseudotime_heatmap.{pdf,png}|xargs rm monocle.RData

#BD比对数据，结果整理命令
ls *png *csv *st |xargs -I {} cp "{}" /data/X101SC19031497-Z01-F023-B10/result/Day3_1/

ls *png *csv *st |xargs -I {} cp "{}" /data/X101SC19031497-Z01-J002-B14/result/TDF_PB_60
ls *png *csv *st |xargs -I {} cp "{}" /data/X101SC19031497-Z01-J002-B14/result/TDF_BM_60

```

