# 统计hotspot的个数，和调控基因的数量
bedtools makewindows -g ga.txt -w 1000000 -s 1000000 > windows.bed

bedtools intersect -a chr_bin/windows.bed -b 4D_all.bed.500.bc.un.track.bed -wa -wb|awk '{$7=$7"\t1";print}' OFS='\t'|bedtools groupby -g 1-3 -c 7,8,9 -o collapse,sum,sum > 4D_window.bed




# hotsopt调控的基因
module load BEDTools/2.27
for i in 4D 8D 12D 16D 20D
do
bedtools intersect -a ${i}_hotspot.bed -b ${i}PA_filter.bed -wa -wb |bedtools groupby -g 1-5 -c 9,11 -o collapse > ${i}_hotspot_annotGene.txt
done



# hotspot取并集

cat 4DPA_sorted_hotspot.bed|awk '{$4="4DPA_Hot"NR;print}' OFS='\t'|sed 's/4DPA/04DPA/g' > 4DPA_sorted_hotspot_ID.bed
cat 8DPA_sorted_hotspot.bed|awk '{$4="8DPA_Hot"NR;print}' OFS='\t'|sed 's/8DPA/08DPA/g' > 8DPA_sorted_hotspot_ID.bed
cat 12DPA_sorted_hotspot.bed|awk '{$4="12DPA_Hot"NR;print}' OFS='\t' > 12DPA_sorted_hotspot_ID.bed
cat 16DPA_sorted_hotspot.bed|awk '{$4="16DPA_Hot"NR;print}' OFS='\t' > 16DPA_sorted_hotspot_ID.bed
cat 20DPA_sorted_hotspot.bed|awk '{$4="20DPA_Hot"NR;print}' OFS='\t' > 20DPA_sorted_hotspot_ID.bed

cat 4DPA_sorted_hotspot_ID.bed 8DPA_sorted_hotspot_ID.bed 12DPA_sorted_hotspot_ID.bed 16DPA_sorted_hotspot_ID.bed 20DPA_sorted_hotspot_ID.bed |sort -k1,1n -k2,2n > alltime_sorted_hotspot_ID.bed
bedtools merge -i alltime_sorted_hotspot_ID.bed  -c 4,5,6 -o collapse,sum,collapse > merge_hotspot_ID.bed



bedtools merge -i alltime_sorted_hotspot.bed  -c 4 -o collapse > merge_0k.bed

bedtools intersect -a ${i}PA_sorted_hotspot.bed -b ~/ga/hotspot/hotspot_exp_filter_5kb/events/${i}PA_filter.bed -wa -wb |bedtools groupby -g 1-6 -c 10,12 -o collapse > ${i}_hotspot_annotGene.txt; done

bedtools merge -i alltime_hotspot_sorted.bed  -c 4,5,6 -o collapse,sum,collapse > merge_hotspot_ID.bed

sed -i 's/^/chr&/g' merge_hotspot_ID.bed
sed 's/^/chr&/g' alltime_hotspot.bed > alltime_hotspot.txt

module load BEDTools/2.27
bedtools intersect -a alltime_hotspot.txt -b ~/ga/hotspot/hotspot_exp_filter_20kb/events/${i}PA_filter.bed -wa -wb |bedtools groupby -g 1-6 -c 10,12 -o collapse > ${i}_hotspot_annotGene.txt





for i in 4 8 12 16 20;do awk 'NR>1' ../${i}DPA_filter.bed.20000.bc.un.track.bed|cut -f 1-5 > ${i}DPA_hotspot.txt;done
for i in 4DPA 8DPA 12DPA 16DPA 20DPA;do awk '$5>5{print $0,"'$i'"}' OFS='\t' ${i}_hotspot.txt > ${i}_hotspot_filter5.txt;done
for i in 4DPA 8DPA 12DPA 16DPA 20DPA;do sed 's/chr//' ${i}_hotspot_filter5.txt |sort -k1,1n -k2,2n > ${i}_sorted_hotspot.bed;done

for i in 4 8 12 16 20;do sed  's/^/chr&/g' ../${i}DPA_sorted_hotspot.bed > ${i}DPA_sorted_hotspot.bed ;done
cat 4DPA_sorted_hotspot.bed 8DPA_sorted_hotspot.bed 12DPA_sorted_hotspot.bed 16DPA_sorted_hotspot.bed 20DPA_sorted_hotspot.bed|sort -k1,1n -k2,2n > alltime_sorted_hotspot.bed
bedtools merge -i alltime_sorted_hotspot.bed  -c 4,5,6 -o collapse,sum,collapse > merge_0k.bed
sed -i  's/^/chr&/g' merge_0k.bed