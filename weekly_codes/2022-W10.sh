# ~/work_new
# 样本品种名对应
cat Ga_id.txt|awk -F '\t' '$3="J"$3' OFS='\t' > Ga_id1.txt
awk 'NR==FNR{a[$3]=$2;next}{print $1"\t"a[$1]}' Ga_id1.txt sample.txt > sample_ID.txt



awk -F'\t' 'NR==FNR{a[$1]=$2;next}{print $0,a[$1]}' OFS='\t' GA_pinyin.txt Ga_id1.txt > Ga_id_pinyin.txt
awk -F'\t' 'NR==FNR{a[$3]=$4;next}{print $1"\t"a[$1]}' Ga_id_pinyin.txt sample.txt > sample_ID_pinyin.txt


awk -F'\t' 'NR==FNR{a[$1]=$2"\t"$3"\t"$4"\t"$5"\t"$6;next}{print $0,a[$1]}' OFS='\t' GA_pinyin.txt Ga_id1.txt > Ga_id_pinyin.txt
awk -F'\t' 'NR==FNR{a[$3]=$4"\t"$5"\t"$6"\t"$7"\t"$8;next}{print $1"\t"a[$1]}' Ga_id_pinyin.txt sample.txt > sample_ID_pinyin.txt


# 2022-03-08

