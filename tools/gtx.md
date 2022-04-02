error:吐核

失败的原因应该是没指定输出目录。所以在原有的目录下输出结果，但是我没有写入的权限。

现在我指定`-O`指定输出目录了

/public/home/yqzhang/zyqi/yuan_upland/BYUGhRace_222

```bash
module load GTZ/2.1.4
mkdir cache
mkdir fastq_data
cat sample.txt |while read i
do
  gtz1=${i}_1.clean.fq.gz.gtz
  gtz2=${i}_2.clean.fq.gz.gtz
  fq1=${i}_1.clean.fq.gz
  fq2=${i}_2.clean.fq.gz
  nt=1
  bsub -J ${i} -o %J.${i}.out -e %J.${i}.err -n $nt -q q2680v2 "
  #cp /data/cotton/JianyingLi/PhaseII_PAN/BYUGhRace_222/CleanData/$gtz1 .
  #cp /data/cotton/JianyingLi/PhaseII_PAN/BYUGhRace_222/CleanData/$gtz2 .

  gtz  -d -z gtz_data/$gtz1  --cache-path cache/ -p $nt -O fastq_data
  gtz  -d -z gtz_data/$gtz2  --cache-path cache/ -p $nt -O fastq_data
"
done
```



查看软件的帮助文件很重要

`gtz -h`

