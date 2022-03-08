
## hotspot基因表达热图
```R
library(RColorBrewer)
library(pheatmap)

f <- read.table('hotspot_chr05_gene_exp_head.txt',stringsAsFactors = F,header = T,check.names = F,row.names = 1)

options(repr.plot.width=7,repr.plot.height=4)
pdf("hotspot_gene_1.pdf",width = 7,height = 4)
color <- colorRampPalette(rev(brewer.pal(9, "RdBu")))(100)
#color <- colorRampPalette(colors = c("blue","white","red"))(100)
bk = unique(c(seq(-4,4, length=100)))
p <- pheatmap(as.matrix(f),color=color,scale='row',cluster_cols=T,cluster_rows=T,breaks = bk,show_rownames=F,show_colnames=F,cutree_cols = 2,cutree_rows = 2)
dev.off()
col_cluster <- cutree(p$tree_col,k=2)
```



## heatmap

/Users/zhengyangqi/Desktop/二倍体项目/棉花二倍体项目桌面上的文件/gwas位点分析1013/heatmap

```R
library(RColorBrewer)
library(tidyverse)

library(pheatmap)

df <- read.table('coloc_gene.txt',header=T,stringsAsFactors = F)

df_wide <- pivot_wider(df,names_from = TIME, values_from = COLOC.PP4)

df_wide <- as.data.frame(df_wide)
rownames(df_wide) <- df_wide$GENE
head(df_wide)

df_wide <- df_wide[,c(3,4,6,5,2)]

brewer.pal(9, "RdBu")

# color <- colorRampPalette(rev(c("#ff0000", "white")))(100)

# color <- colorRampPalette(brewer.pal(9, "RdBu"))(1000)
# color <- rev(color)

color <- rev(brewer.pal(7, "RdBu"))

pdf("output.pdf",width = 3.8,height = 3)
pheatmap(as.matrix(df_wide),
         cluster_row = FALSE, cluster_col = FALSE, angle_col = 0,
         color = color,
         #cellwidth=40, cellheight = 40,
         #border_color="black",
         legend_breaks = c(-0.19,-0.12,-0.05,0.05,0.12,0.19),
         legend_labels =c(-0.94,-0.87,-0.8,0.8,0.87,0.94),
         border=TRUE
         )
dev.off()

```



## 热图

```R
library(RColorBrewer)
library(pheatmap)
color <- rev(brewer.pal(7, "RdBu"))

pdf("output.pdf",width = 3.8,height = 3)
pheatmap(as.matrix(df_wide),
         cluster_row = FALSE, cluster_col = FALSE, angle_col = 0,
         color = color,
         #cellwidth=40, cellheight = 40,
         #border_color="black",
         legend_breaks = c(-0.19,-0.12,-0.05,0.05,0.12,0.19),
         legend_labels =c(-0.94,-0.87,-0.8,0.8,0.87,0.94),
         border=TRUE
         )
dev.off()
```
