#======================================QTL overlap=======================================

# ~/ga/uplandCotton_public_QTL
# 将陆地棉的序列比对到二倍体基因组上

module load BEDTools/2.27
bedtools getfasta -name -fi Ghirsutum_genome.fasta -bed qtl_pos.txt -fo uplandCotton_public_QTL.fa



module load BLAST+/2.10.1

blastn -db ~/ga/A2_public_QTL/our_genome/Lachesis_assembly_changed -query uplandCotton_public_QTL.fa -num_threads 10 -outfmt 7 -out uplandCotton_public_QTL_blast

# Fields: query acc.ver, subject acc.ver, % identity, alignment length, mismatches, gap opens, q. start, q. end, s. start, s. end, evalue, bit score



awk '!a[$1,$2]++' uplandCotton_public_QTL_blast > uplandCotton_public_QTL_blast_top

grep -v 'Contig' uplandCotton_public_QTL_blast_top > uplandCotton_public_QTL_blast_top_deleteContig

cat uplandCotton_public_QTL_blast| awk '{if($1!~/^#/)print}'|awk '!a[$1]++'|grep -v "Contig"  > uplandCotton_public_QTL_blast_top1

cat uplandCotton_public_QTL_blast_top1|awk '{print $2,$9,$10,$1}' OFS='\t' > uplandCotton_public_QTL_blast_top1_pos.txt









# 分析位点是否有重合
# ~/ga/uplandCotton_public_QTL/merge


# excel复制过去会有空格
sed -i 's/ *//g' fl.txt

grep FL uplandCotton_public_QTL_blast_top1_pos.txt > fl_query.txt
# blast: s. start可能大于s. end
cat fl_query.txt|awk '{if ($2>$3) print $1,$3,$2,$4;else print}' OFS='\t' > fl_query_reverse.txt

bedtools intersect -a fl.txt -b fl_query_reverse.txt -wa -wb -nonamecheck|bedtools groupby -g 1-4 -c 8 -o collapse > fl_overlap.txt


for i in FL FS FU FE
do
  sed -i 's/ *//g' $i.txt
  grep $i uplandCotton_public_QTL_blast_top1_pos.txt > ${i}_query.txt
  cat ${i}_query.txt|awk '{if ($2>$3) print $1,$3,$2,$4;else print}' OFS='\t' > ${i}_query_reverse.txt
  bedtools intersect -a $i.txt -b ${i}_query_reverse.txt -wa -wb -nonamecheck|bedtools groupby -g 1-4 -c 8 -o collapse > ${i}_overlap.txt
done





# expand
# ~/ga/uplandCotton_public_QTL/merge/expand50k

cat uplandCotton_public_QTL_blast_top1_pos.txt|awk '{ p=$2 - 100000; if(p<0) p=0; print $1,p,$3+100000,$4 }' OFS='\t' > uplandCotton_public_QTL_blast_top1_pos.txt

for i in FL FS FU FE
do
  grep $i uplandCotton_public_QTL_blast_top1_pos.txt > ${i}_query.txt
  cp ../$i.txt .
  cat ${i}_query.txt|awk '{if ($2>$3) print $1,$3,$2,$4;else print}' OFS='\t' > ${i}_query_reverse.txt
  bedtools intersect -a $i.txt -b ${i}_query_reverse.txt -wa -wb -nonamecheck|bedtools groupby -g 1-4 -c 8 -o collapse > ${i}_overlap.txt
done









##### ~/ga/uplandCotton_public_QTL/lizhongxu

cat qtl_pos.txt |awk '{print "Ghir_"$2,$3,$4,$1}' OFS='\t' > qtl_pos_1.txt

module load BEDTools/2.27
bedtools getfasta -name -fi ../Ghirsutum_genome.fasta -bed qtl_pos_1.txt -fo uplandCotton_public_QTL.fa

module load BLAST+/2.10.1

blastn -db ~/ga/A2_public_QTL/our_genome/Lachesis_assembly_changed -query uplandCotton_public_QTL.fa -num_threads 10 -outfmt 7 -out uplandCotton_public_QTL_blast_linzhongxu






cat uplandCotton_public_QTL_blast_linzhongxu| awk '{if($1!~/^#/)print}'|awk '!a[$1]++'|grep -v "Contig"  > uplandCotton_public_QTL_blast_top1


module load BEDTools/2.27

cat uplandCotton_public_QTL_blast_top1|awk '{print $2,$9,$10,$1}' OFS='\t' > uplandCotton_public_QTL_blast_top1_pos.txt

for i in FL FS FU FE
do
  grep $i uplandCotton_public_QTL_blast_top1_pos.txt > ${i}_query.txt
  cat ${i}_query.txt|awk '{if ($2>$3) print $1,$3,$2,$4;else print}' OFS='\t' > ${i}_query_reverse.txt
  bedtools intersect -a $i.txt -b ${i}_query_reverse.txt -wa -wb -nonamecheck|bedtools groupby -g 1-4 -c 8 -o collapse > ${i}_overlap.txt
done


# 没有overlap


# 大于10k的片段
cat uplandCotton_public_QTL_blast_linzhongxu| awk '{if($1!~/^#/)print}'|awk '$4>10000'|grep -v "Contig"  > uplandCotton_public_QTL_blast_10k

module load BEDTools/2.27

cat ../uplandCotton_public_QTL_blast_10k|awk '{print $2,$9,$10,$1}' OFS='\t' > uplandCotton_public_QTL_blast_top1_pos.txt

for i in FL FS FU FE
do
  grep $i uplandCotton_public_QTL_blast_top1_pos.txt > ${i}_query.txt
  cat ${i}_query.txt|awk '{if ($2>$3) print $1,$3,$2,$4;else print}' OFS='\t' > ${i}_query_reverse.txt
  bedtools intersect -a $i.txt -b ${i}_query_reverse.txt -wa -wb -nonamecheck|bedtools groupby -g 1-4 -c 8 -o collapse > ${i}_overlap.txt
done
