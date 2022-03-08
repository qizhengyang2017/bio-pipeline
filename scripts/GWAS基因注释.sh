module load BEDTools/2.27
bedtools intersect -a qtl.bed -b change.Chr_genome_final_gene_1based.bed -wa -wb|bedtools groupby -g 1-4 -c 8 -o collapse,count > qtl_gene_count.txt
python format.py > QTL_gene.txt
awk 'NR==FNR{a[$4]=$1"\t"$2"\t"$3;next}{b=a[$2];print b,$2,$1}' OFS='\t' change.Chr_genome_final_gene_1based.bed QTL_gene.txt > QTL_gene_pos.txt


# 启动子和基因区有突变的基因
cat QTL_gene_pos.txt|while read -a gene;do let "start=${gene[1]}-2000";let "end=${gene[2]}+2000"; grep ${gene[3]} ~/ga/annovar/filter2_Q600_SNPs_joint_216.variant_function|awk '$4>="'${start}'" && $4<="'${end}'"{print "'${gene[4]}'","'${gene[3]}'",$0}' OFS='\t';done >> QTL_gene_pos_variantAnnot_updown.txt
grep  -v "downstream" QTL_gene_pos_variantAnnot_updown.txt > QTL_gene_pos_variantAnnot_promoter.txt

grep "upstream" QTL_gene_pos_variantAnnot_updown.txt > QTL_promoter.txt

# 非同义突变
cat QTL_gene_pos.txt|while read -a gene;do grep ${gene[3]} ~/ga/annovar/filter2_Q600_SNPs_joint_216.exonic_variant_function|awk '$6>="'${gene[1]}'" && $6<="'${gene[2]}'"{print "'${gene[4]}'","'${gene[3]}'",$0}' OFS='\t';done >> QTL_gene_pos_exonicAnnot.txt
cat QTL_gene_pos_exonicAnnot.txt|awk -F'\t' '$4=="nonsynonymous SNV" || $4=="stopgain" || $4=="stoploss"' > QTL_gene_nonsynonymous.txt

# 功能注释
cat QTL_promoter.txt|awk '{print $1,$2}' OFS='\t'|sort|uniq > promoter_variant_gene.txt
cat QTL_gene_pos_variantAnnot_promoter.txt|awk '{print $1,$2}' OFS='\t'|sort|uniq > all_variant_gene.txt
cat QTL_gene_nonsynonymous.txt |awk '{print $1,$2}' OFS='\t'|sort|uniq > nonsynonymous_gene.txt

awk -F '\t' 'NR==FNR{a[$1]=$2"\t"$4;next}{b=a[$2];print $0,b}' OFS='\t' A2_anno_gene.txt promoter_variant_gene.txt > promoter_variant_gene_annot.txt
awk -F '\t' 'NR==FNR{a[$1]=$2"\t"$4;next}{b=a[$2];print $0,b}' OFS='\t' A2_anno_gene.txt all_variant_gene.txt > all_variant_gene_annot.txt

awk -F '\t' 'NR==FNR{a[$1]=$2"\t"$4;next}{b=a[$2];print $0,b}' OFS='\t' A2_anno_gene.txt nonsynonymous_gene.txt > nonsynonymous_gene_annot.txt

# 注释nonsynonymous
cat nonsynonymous_gene.txt|awk '{print $0"\tnonsynonymous"}' > for_nonsynonymous_annot.txt
awk -F '\t' 'NR==FNR{a[$2]=$3;next}{print a[$2]"\t"$0}' for_nonsynonymous_annot.txt all_variant_gene_annot.txt > final_annot_gwas_gene.txt


# awk -F '\t' 'NR==FNR{a[$4]=$1"\t"$2"\t"$3;next}{$2=a[$2]"\t"$2;print $0}' OFS='\t' change.Chr_genome_final_gene_1based.bed withvariant_gene_promoter_annot.txt > withvariant_gene_promoter_annot_pos.txt

# sed 's/ | /\t/g;s/Symbols: //' withvariant_gene_promoter_annot_pos.txt > withvariant_gene_promoter_annot_pos_format.txt


