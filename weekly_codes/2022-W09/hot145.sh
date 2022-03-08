# ~/ga/candidate_gene_blast。一开始的目录，拿hot145片段分析。


# 提取hot145的序列

module load BEDTools/2.27
bedtools getfasta -name -fi ~/ga/A2_public_QTL/our_genome/Lachesis_assembly_changed.fa -bed hot145.bed -fo hot145.fa




# 比对到其他9个基因组
~/../cotton/public_data/GWAS_Fiber_ljy/HAU_Genome_Updated/



module load BLAST+/2.10.1



for i in A1 A1-a C1 B1 D5 K2 E1 G1 F1
do
  mkdir $i
  cd $i
  ln -s ~/ga/candidate_gene_blast/genome/$i/$i.Chr.fa
  cd ..
done


# makedb
module load BLAST+/2.10.1
for i in A1 A1-a C1 B1 D5 K2 E1 G1 F1
do
  cd $i
  bsub -q normal -o %J.out -e %J.err "
  makeblastdb -in $i.Chr.fa -dbtype nucl -out $i
  " 
  cd ..
done


# blastn
module load BLAST+/2.10.1
for i in A1 A1-a C1 B1 D5 K2 E1 G1 F1
do
  bsub -q normal -n 2 -o %J.out -e %J.err "
  blastn -db blastdb/$i/$i -query hot145.fa -num_threads 2 -outfmt 6 -out ${i}_hot145_blast
  " 
done


# filter 
# identity > 90%
# len > 5k

for i in A1 A1-a C1 B1 D5 K2 E1 G1 F1
do
  bsub -q normal -n 1 -o %J.out -e %J.err "
  cat ${i}_hot145_blast|awk '\$3>90 && \$4>5000' > ${i}_hot145_blast_filter
  " 
done






# ~/ga/InHot145Gene

module load BEDTools/2.27
#bedtools intersect -a hot145.bed -b change.Chr_genome_final_gene.bed -wa -wb |bedtools groupby -g 1-4 -c 8 -o collapse > hot145_gene
bedtools intersect -a hot145.bed -b change.Chr_genome_final_gene.bed -wa -wb  > hot145_gene

# 只有一个基因
# Garb_05G038020	AT1G28280	1.97e-57
# https://www.arabidopsis.org/servlets/TairObject?type=locus&name=At1g28280


# ~/ga/InHot145Gene
# 这个基因分析

module load BEDTools/2.27
module load BLAST+/2.10.1

bedtools getfasta -name -fi ~/ga/A2_public_QTL/our_genome/Lachesis_assembly_changed.fa -bed Garb_05G038020.bed -fo Garb_05G038020.fa
for i in A1 A1-a C1 B1 D5 K2 E1 G1 F1 A2
do
  bsub -q normal -n 1 -o %J.out -e %J.err "
  blastn -db ~/ga/candidate_gene_blast/blastdb/$i/$i -query Garb_05G038020.fa -num_threads 1 -outfmt 6 -out ${i}_Garb_05G038020_blast
  "
done


# gene +_ 3k
# ~/ga/InHot145Gene/gene3k



##########========================
# ~/ga/InHot145Gene/gene3k

#cat all_format7 |awk '$3>90 && $4>500' > all_format7_filter

cat all_format7 |awk -F '\t' '$0~/^#/{print}$3>90 && $4>500{print}' > all_format7_filter.txt






# ~/ga/InHot145Gene

cat all_format7|awk '$0~"^# Database" || $0~"^Garb"' > all_format7_1.txt

cat all_format7_1.txt|sed 's# Database: /public/home/zyqi/ga/candidate_gene_blast/blastdb/.*/##' > all_format7_2.txt


# ~/ga/InHot145Gene/gene3k

cat all_format7|awk '$0~"^# Database" || $0~"^Garb"' > all_format7_1.txt

cat all_format7_1.txt|sed 's# Database: /public/home/zyqi/ga/candidate_gene_blast/blastdb/.*/##' > all_format7_2.txt
cat all_format7_2.txt|awk -F '\t' '{if($0~"^#")print;else if($2=="Chr05")print}' > all_format7_3.txt










