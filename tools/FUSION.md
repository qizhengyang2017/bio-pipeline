~/cotton_fiber/ma_1081/twas

需要conda twas环境



1. 建LDREF
2. FL_sumstats.txt文件
3. assoc.sh



```sh
for i in 4D 8D 12D 16D 20D
do
  mkdir $i
  cd $i
  ln -s /data/cotton/zyqi/archives/fusion/blup_376/$i/weights_$i
  ln -s /data/cotton/zyqi/archives/fusion/blup_376/$i/$i.pos
  cd ..
done
```



```sh
bsub -q q2680v2 -n 1 -o %J.out -e %J.err "sh assoc.sh 12D FL"
bsub -q q2680v2 -n 1 -o %J.out -e %J.err "sh assoc.sh 4D FL"
bsub -q q2680v2 -n 1 -o %J.out -e %J.err "sh assoc.sh 8D FL"
bsub -q q2680v2 -n 1 -o %J.out -e %J.err "sh assoc.sh 16D FL"
bsub -q q2680v2 -n 1 -o %J.out -e %J.err "sh assoc.sh 20D FL"
```



23-26号染色体

/data/cotton/zyqi/archives/fusion/TWAS_log

构建权重文件的时候，确实把23-26号染色体上的基因的染色体编号变成1了。

wgt.matrix：只有ID

snps：有染色体编号。为1



1-22号染色体

/data/cotton/zyqi/archives/fusion/TWAS_log_bak





不需要改权重文件里的染色体信息，即xxx.wgt.RDat里的`snps`对象，因为：

FUSION.assoc_test.R输出：坐标用的4D.pos里的信息，会用到xxx.wgt.RDat里的`wgt.matrix`，里面有SNP ID



```sh
out.tbl$CHR[w] = wgtlist$CHR[w]
out.tbl$P0[w] = wgtlist$P0[w]
out.tbl$P1[w] = wgtlist$P1[w]
out.tbl$ID[w] = wgtlist$ID[w]
```





加coloc

/data/cotton/zyqi/Ga/Ga_fusion/fusion_1





也加coloc参数

~/cotton_fiber/ma_1081/twas

```sh
# pos文件有点区别
for i in 0D 4D 8D 12D 16D 20D
do
  mkdir $i.coloc
  cd $i.coloc
  ln -s /data/cotton/zyqi/archives/fusion/blup_376/$i/weights_$i
  cat /data/cotton/zyqi/archives/fusion/blup_376/$i/$i.pos|awk '{print "ma_1081",$0}' OFS='\t' |sed '1s/ma_1081/PANEL/'> $i.pos
  cd ..
done
```



```sh
source  /public/home/zyqi/anaconda3/bin/activate twas

FUSION="/public/home/zyqi/software/fusion_twas-master"
PRE=$1
trait=$2
cd $PRE.coloc
for i in {1..26}
do
mkdir -p $trait/chr$i
Rscript $FUSION/FUSION.assoc_test.R \
--sumstats ~/cotton_fiber/ma_1081/twas/fusion_input/${trait}_sumstats.txt \
--weights $PRE.pos \
--weights_dir . \
--ref_ld_chr ~/cotton_fiber/ma_1081/twas/LDREF/ma_1081. \
--chr $i \
--out $trait/chr$i/$PRE.$i.dat \
--coloc_P 0.05 \
--GWASN 1081 \
--PANELN ../panelN.txt

mv $trait/chr$i/$PRE.$i.dat $trait/
done
```



~/cotton_fiber/du_1200/twas/fusion_input

```
cat FS_Num2_out|awk 'NR==1{print}NR>1{$1=$2"_"$4;print}' OFS='\t' > FS_out
cat FE_Num3_out|awk 'NR==1{print}NR>1{$1=$2"_"$4;print}' OFS='\t' > FE_out
```



/data/cotton/zyqi/gwas_419/twas_1

```sh
awk 'FNR==1 && NR!=1{next;}{print}' add_FDR/*.txt > all_trait_time_twas.txt
cat all_trait_time_twas.txt|awk -F '\t' '$31<0.05'> all_trait_time_twas_sig.txt
awk 'NR==FNR{a[$1]=$0;next}{print $0,a[$4]}' OFS='\t' Gh_anno_gene_2.txt all_trait_time_twas_sig.txt > all_trait_time_twas_sig_annot.txt

# 性状，时期排序
cat all_trait_time_twas_sig_annot.txt |awk 'NR>1{a=$3;sub(/D/,"",a);print a,$0}' OFS='\t'|sort -k3,3 -k1,1n |cut -f 2- > all_trait_time_twas_sig_annot_sorted.txt 
```







