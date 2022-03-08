~/ga/JCVI_test


```bash
module load jcvi/1.0.6


# gff转bed
python -m jcvi.formats.gff bed --type=mRNA --key=Name Tcacao_233_v1.1.gene.gff3.gz -o cacao.bed



# 准备CDS序列
# 每行的碱基数变了
python -m jcvi.formats.fasta format --sep="|" Vvinifera_145_Genoscope.12X.cds.fa.gz grape.cds
python -m jcvi.formats.fasta format --sep="|" Tcacao_233_v1.1.cds.fa.gz cacao.cds






# 基因水平共线性搜索
# 会生成grape.cacao.lifted.anchors文件，这是个什么文件
python -m jcvi.compara.catalog ortholog grape cacao --cscore=0.7


# --iter=1 表示提取每个葡萄基因只对应一个桃子或可可基因的。如果是2，则提取对应2个基因的
python -m jcvi.compara.synteny mcscan grape.bed grape.cacao.lifted.anchors --iter=1 -o grape.cacao.i1.blocks




##-------------------------------------------------


# 自定义blocks.layout文件
cat grape.bed cacao.bed > grape_cacao.bed


head -50 grape.cacao.i1.blocks > blocks
python -m jcvi.graphics.synteny blocks grape_cacao.bed blocks.layout


# 取前五个基因
head -5 grape.cacao.i1.blocks > blocks1
python -m jcvi.graphics.synteny blocks1 grape_cacao.bed blocks.layout



# 最后得到的grape.blocks包含大量的基因匹配
python -m jcvi.formats.base join grape.peach.i1.blocks grape.cacao.i1.blocks --noheader | cut -f1,2,4,6 > grape.blocks



# 挑选的前50列进行展示
head -50 grape.blocks > blocks


# 自定义blocks.layout文件


# 绘图
cat grape.bed peach.bed cacao.bed > grape_peach_cacao.bed
python -m jcvi.graphics.synteny blocks grape_peach_cacao.bed blocks.layout
```

