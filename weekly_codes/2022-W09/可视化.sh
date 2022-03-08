# Fields: query acc.ver, subject acc.ver, % identity, alignment length, mismatches, gap opens, q. start, q. end, s. start, s. end, evalue, bit score

# 7,8


# 2,9,10

# Chr05
# 85742648
# 85764898


# 9,10的坐标加这个85742648


# ~/work_new/ga/hot145_circos

cat C1_hot145_blast_filter|awk '{print "Chr5",$7+85742648,$8+85742648,$2,$9,$10}' > C1_link.txt

circos -conf C1.conf -file C1