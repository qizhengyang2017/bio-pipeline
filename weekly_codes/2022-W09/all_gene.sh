# ~/ga/InHot145Gene/all_gene

grep -f gene_uniq.txt change.Chr_genome_final_gene.bed > all_gene.bed
cat all_gene.bed|awk '{print $1,$2,$3,$4}' OFS='\t' > all_gene_1.bed


module load BEDTools/2.27
module load BLAST+/2.10.1

bedtools getfasta -name -fi ~/ga/A2_public_QTL/our_genome/Lachesis_assembly_changed.fa -bed all_gene_1.bed -fo all_gene.fa
for i in A1 A1-a C1 B1 D5 K2 E1 G1 F1 A2
do
  bsub -q normal -n 1 -o %J.out -e %J.err "
  blastn -db ~/ga/candidate_gene_blast/blastdb/$i/$i -query all_gene.fa -num_threads 5 -outfmt 7 -out ${i}_all_gene_blast
  "
done


cat *blast > all_blast

# 过滤条件
cat all_blast |awk -F '\t' '$0~/^#/{print}$3>90 && $4>500{print}' > all_filter.txt

cat all_filter.txt|awk '$0~"^# Database" || $0~"^Garb"' > all_filter_1.txt

cat all_filter_1.txt|sed 's# Database: /public/home/zyqi/ga/candidate_gene_blast/blastdb/.*/##' > all_filter_gene.txt




# 2022-03-07
# query acc.ver, subject acc.ver, % identity, alignment length, mismatches, gap opens, q. start, q. end, s. start, s. end, evalue, bit score


# 先不过滤

cat all_blast|awk '$0~"^# Database" || $0~"^Garb"' > all_filter_1.txt

cat all_filter_1.txt|sed 's# Database: /public/home/zyqi/ga/candidate_gene_blast/blastdb/.*/##' > all_filter_gene.txt

python file_format.py all_filter_gene.txt > all_final.txt





########################################## 3k
# ~/ga/InHot145Gene/all_gene/gene3k

cat all_gene_1.bed|awk '{ p=$2 - 3000; if(p<0) p=0; print $1,p,$3+3000,$4 }' OFS='\t' >  all_gene3k.bed



module load BEDTools/2.27
module load BLAST+/2.10.1

bedtools getfasta -name -fi ~/ga/A2_public_QTL/our_genome/Lachesis_assembly_changed.fa -bed all_gene3k.bed -fo all_gene.fa
for i in A1 A1-a C1 B1 D5 K2 E1 G1 F1 A2
do
  bsub -q normal -n 1 -o %J.out -e %J.err "
  blastn -db ~/ga/candidate_gene_blast/blastdb/$i/$i -query all_gene.fa -num_threads 5 -outfmt 7 -out ${i}_all_gene_blast
  "
done

cat *blast > all_blast
cat all_blast |awk -F '\t' '$0~/^#/{print}$3>90 && $4>500{print}' > all_filter.txt

cat all_filter.txt|awk '$0~"^# Database" || $0~"^Garb"' > all_filter_1.txt

cat all_filter_1.txt|sed 's# Database: /public/home/zyqi/ga/candidate_gene_blast/blastdb/.*/##' > all_filter_3k.txt

# 125424 all_filter_3k.txt


python file_format.py all_filter_3k.txt > all_filter_3k_final.txt



