## 主题

```R
mytheme <-   theme(
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    panel.background = element_rect(fill="white",colour="black",size=0.5),
    legend.position="none",
    axis.text.x=element_blank(),
    axis.ticks.x = element_blank(),
    panel.background = element_rect(fill='transparent',color='black'),
    axis.text = element_text(color='black',face = 'bold') 
)
```
## 坐标轴





## 图例
```R
guides(fill=guide_legend(nrow=2))

theme(legend.position = 'bottom',legend.text =element_text(size=8),legend.key.size=unit(0.17,'in')

theme(legend.position = c(0.7, 0.7))

guides(fill = guide_legend(title = "eQTLs/gene"))

theme(legend.position = 'right',
        legend.title=element_text(size=13,face="plain",color="black"),
        legend.key=element_rect(fill='transparent'))

theme(legend.key.size = unit(1, 'lines')) #Change spacing size

```

## 添加标签
```R

library(dplyr)
data <- mpg %>% group_by(class) %>% filter(row_number(desc(hwy))==1)
ggplot(mpg,aes(displ,hwy))+geom_point(aes(color=class))+geom_text(aes(label=model),data=data)

# 标签不重叠
geom_label_repel(aes(label=SNP),data=a2)
geom_text_repel(aes(label=SNP),data=a2) # text没有外框



```


## 颜色
```R
library(RColorBrewer)
display.brewer.all()
color1 <- brewer.pal(6,"Blues")[2:6]
show_col(color1)

# 颜色梯度
color <- colorRampPalette(rev(c("#ff0000", "white")))(100)
```

## jupyter lab 图片大小
options(repr.plot.width=10, repr.plot.height=8)


---


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

## 散点图+拟合线
```R
p2 <- ggplot(p_group, aes(x = Ghir_D09_35396780, y = FE, color = Ghir_A10_58433793)) + 
    geom_point() + 
    geom_smooth(method = "lm", se = FALSE) + scale_color_manual(values = mypalette) + scale_x_continuous(breaks=c(0,2),labels=c('CC','GG'),expand=c(0.1,0.1)) + theme_classic2() + mytheme + theme(legend.position = 'top') + ylab('FE (%)')
```

## 折线图

```R
ggplot(f,aes(x=Start,y=Nums)) + geom_line(color='blue') + 
    scale_x_continuous(breaks = chr$label1, labels = chr$chr_name, expand = c(0, 0)) +
    geom_text(mapping=aes(x=label1,y=1600,label=chr_name),data=chr,size=3,color='black',fontface='bold') + 
    geom_vline(xintercept = chr$label, color = c('gray'), size = 0.35,linetype=2) +
    labs(x=NULL,y=NULL) +
    scale_y_continuous(expand=expansion(mult = c(0.05, 0.1))) + mytheme
```




## 饼图

```R
ggplot(f3, aes(x ='',y = percentage, fill = type)) +
  geom_bar(stat = "identity", width = 1) + 
  coord_polar(theta = "y") +
  facet_wrap(~trait,nrow=1) +
  theme(axis.ticks = element_blank()) + 
  theme(panel.background=element_rect(fill='transparent', color='black')) + #背景和边框
  xlab(NULL) + ylab(NULL) +
  theme(axis.text.x=element_blank()) + # x轴刻度
  theme(strip.background = element_rect(color = "white", fill = "white")) + # 分面标题背景
  geom_text(aes(x = 1.1, y = midpoint, label = label),size = 3) + # 加上百分比标签。y:两边距离, x:到圆心距离
  scale_fill_manual(values=c('#90a0c8','#ee926b'),label=c('no','yes')) + # 图例标签
  guides(fill = guide_legend(title=NULL,reverse=TRUE)) # 图例倒序
```




## 曼哈顿图
```R
color <- c('#E64B35FF','#4DBBD5FF','#F39B7FFF','#3C5488FF','#00A087FF')

# options(repr.plot.width=7, repr.plot.height=2.2)
mytheme <-   theme(
    axis.title=element_text(size=10,face="plain",color="black"),
    axis.text = element_text(size=10,face="plain",color="black"),
    legend.title=element_text(size=10,face="plain",color="black"),
    plot.title=element_text(size=10,face="plain",color="black"),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    panel.background = element_rect(fill="white",colour="black",size=0.25),
    strip.text = element_blank()
)

p <- ggplot(a2, aes(pos, logP)) +
    geom_point(aes(color = as.factor(a2$CHR),shape = a2$TIME,fill = as.factor(a2$CHR)),alpha = 0.5,size=2) +
    scale_color_manual(values = c(rep(color,2),color[1:3]))+
    scale_fill_manual(values = c(rep(color,2),color[1:3]))+
    scale_shape_manual(values = 21:25)+
    scale_x_continuous(breaks = chr$x, labels = 1:13, expand = expansion(mult = c(0.007, 0.007)))+
    scale_y_continuous(expand = expansion(mult = c(0.02,0.1))) +
    geom_hline(yintercept = t2, color = c('#4157a8'), size = 0.35,linetype=2)
p <- p+mytheme + ylab(expression(~-log[10]~'(P)')) + xlab(NULL)

p+guides(fill = "none",color= "none",shape=guide_legend(title = NULL)) + 
    theme(legend.position = 'right',
        legend.title=element_text(size=13,face="plain",color="black"),
        legend.key=element_rect(fill='transparent'))

```

## independent cis-eQTL 堆积柱状图
```R
ggplot(plotData,aes(x=time,y=ratio,fill=number))+
  geom_bar(stat = 'identity',width=0.95)+
  scale_fill_manual(values=color1) +
  scale_x_discrete(expand = c(-0.5,0))+
  scale_y_continuous(expand = c(0,0))+
  ylab("Proportion of eGenes")+
  xlab(NULL)+
  guides(fill = guide_legend(title = "eQTLs/gene")) +
  theme_classic()+
  theme(
    panel.background = element_blank(),
    axis.ticks.x =element_line(color='black'),
    axis.ticks.y =element_line(color='black'),
    axis.text.y = element_text(size=8,color = 'black'),
    axis.text.x = element_text(size=8,color='black',angle=35,vjust=1,hjust=1),
    axis.title=element_text(size=8,face="plain",color="black"),
    legend.title=element_text(size=8,face="plain",color="black"),
    legend.text =element_text(size=8),
    legend.key.size=unit(0.15,'in'), #0.1有点长
    #legend.box.background = element_rect(linetype=2),
    legend.background = element_rect(fill=alpha('white', 0.4))，
    legend.position = c(0.7, 0.7)
  )
```

## 分组柱形图
position=position_dodge2()
```R
f_long %>% ggplot(aes(stage,number,fill=type)) + geom_col(position=position_dodge2(),colour = 'black',size=0.2) + 
    theme_classic() + theme(legend.position = 'top') + 
    xlab(NULL) + 
    theme(axis.text.x = element_text(color='black',angle=35,vjust=1,hjust=1)) +
    myfont +
    scale_fill_manual(values = col[c(2,1)]) +
    guides(fill = guide_legend(title = NULL))
```


## 单个位点曼哈顿图
```R
options(repr.plot.width=4, repr.plot.height=2.2)
a2 <- filter(a1,Position > 82.5 & Position < 87.5)

a2 <- filter(a1,Position > 84.8 & Position < 86.7)

ggplot(a2, aes(Position, logP))+geom_point(aes(color=color),size=1) + 
    scale_color_manual(values=color) + 
    mytheme +
    ylab(expression(~-log[10]~'(P)')) + 
    geom_hline(yintercept = t2, color = c('black'), size = 0.35,linetype=2) + scale_y_continuous(expand = expansion(mult=c(0,0.05)))
```

## 小提琴图+箱线图
```R
p <- ggplot(e1[[1]],aes(genotype,exp)) + geom_violin(aes(fill=genotype)) + geom_boxplot(width=0.1) +
        ylab('log1p(FPKM)') + xlab(eqtl) + theme_classic() + myfont + scale_fill_manual(values=col[2:1]) +
        scale_x_discrete(labels = c(e1[[2]],e2[[3]])) + xlab(eqtl) + ggtitle(paste0('P =',e1[[4]]))

p
```

## 小提琴图+箱线图分组
```R
library(ggnewscale) # ggnewscale: Multiple Fill and Colour Scales

library(forcats) #因子处理
library(ggfun) # 圆框


p <- ggplot(ee,aes(time,exp,fill=genotype)) +
    geom_violin(position = position_dodge(0.75)) + 
    scale_fill_manual(values=col,name=NULL,breaks=c(0,2),labels=c(base0,base2)) + # 用guides去不掉Legend标题
    new_scale('fill') + #关键
    geom_boxplot(width=0.1,position = position_dodge(0.75)) +
    scale_fill_manual(values=c('white','white')) +
    ylab(paste0(gene,' (FPKM)')) + xlab(eqtl) + theme_classic() + theme(legend.position = 'none') + myfont
    # scale_y_continuous(expand = expansion(mult = c(0.1,0.3)))
    

p<- p + theme(legend.background=element_roundrect(color="#808080", linetype=2))

p + annotate("text", x = 1:5, y = 45, label = c(e1[[4]],e2[[4]],e3[[4]],e4[[4]],e5[[4]]),size=3) + theme(legend.position = c(0.77,0.77))
```

## 单条染色体曼哈顿图
/data/cotton/zyqi/Ga/Ga_GWAS_new/chr05_hotspot_region
```R
ggplot(a2, aes(Position, logP))+geom_point(color='#E69F00',size=1) +  
    theme_classic() +
    ylab(expression(~-log[10]~'(P)')) + 
    xlab('Chr05 (Mb)') +
    geom_hline(yintercept = t2, color = c('black'), size = 0.35,linetype=2) + scale_y_continuous(expand = expansion(mult=c(0,0.05)))+
    theme(legend.position='none',
         axis.title=element_text(size=13,face="plain",color="black"),
         axis.text=element_text(size=13,face="plain",color="black")) +
    scale_x_continuous(expand = c(0.01,0))

# ggsave('hot5_5.pdf',width=2.2,height=1.8)

ggsave('hot6_allchr.pdf',width=4,height=2)

```

## 柱形图
```R
# color <- c('#2166ac','#b2182b')
color <- c('#999999','#E69F00')

options(repr.plot.width=2.5, repr.plot.height=2.2)
f_long %>% ggplot(aes(stage,number,fill=type)) + geom_col(position=position_dodge2(),colour = 'black',size=0.2) + 
    theme_classic() +
    ylab('Number of cis-eQTLs') +
    scale_y_continuous(expand = expansion(mult = c(0,0.05))) +
    xlab(NULL) + 
    theme(axis.text.x = element_text(color='black',angle=35,vjust=1,hjust=1)) +
    myfont +
    scale_fill_manual(values = color) +
    guides(fill = guide_legend(title = NULL)) + theme(legend.margin  = margin(0,0,0,0))

ggsave('mashr_eQTL_number_new_1101.pdf',width=2.8,height=2.3)
```


## 热图
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


## 画图必加

```R
options(repr.plot.width=2,repr.plot.height=2)
ggplot(df_long,aes(x=time,y=number,fill=type))+
  geom_bar(stat = 'identity',width=0.8)+
  theme_classic()+
  scale_fill_manual(values=color1[3:4],name=NULL) +
  #scale_x_discrete(expand = c(-0.5,0))+
  scale_y_continuous(expand = expansion(mult=c(0,0.05)))+
  ylab(NULL)+
  xlab(NULL)+
  theme(legend.position =c(0.9,0.9),axis.text.x = element_text(color='black',angle=35,vjust=1,hjust=1),
        axis.text = element_text(color = 'black'),legend.key.size=unit(0.15,'in'),
        legend.title=element_text(size=9,face="plain",color="black"))

```

## 图例翻转
https://www.datanovia.com/en/blog/ggplot-legend-title-position-and-labels/
```R
p + scale_fill_manual(values=rev(color1),guide = guide_legend(reverse=TRUE)) + labs(x=NULL,y=NULL) + theme_bw()+ scale_y_continuous(expand = c(0,0)) +  
    theme(legend.key.size=unit(0.15,'in')) + theme(
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    axis.text = element_text(color='black') 
)
```


```R
library(eoffice)
topptx(p,"SC-OG_pca_log.pptx",width=4,height=3)



# eqtl dotplot
time1 <- sub('DPA',' DPA',time)

# size取了0.001，也没有变小
p <- ggplot(f_plot,aes(eqtl_pos,gene_pos)) + geom_point(aes(color=logp),size=0.001) + theme_bw() + 
      theme(panel.grid.major = element_blank(),panel.grid.minor = element_blank(),
            axis.text = element_text(size=8,color='black'),
            axis.title = element_text(size=9,color='black'),
            plot.title = element_text(size=9,color='black'),
            legend.title=element_text(size=9,color='black'),
            legend.text=element_text(size=9,color='black'),
            legend.key.size=unit(0.15,'in'))

p1 <- p + geom_vline(xintercept = b,color='black',size=0.3,linetype=2) +
        geom_hline(yintercept = b,color='black',size=0.3,linetype=2) +
        scale_x_continuous(expand = c(0,0),breaks = t,labels = 1:13) +
        scale_y_continuous(expand = c(0,0),breaks = t,labels = 1:13) +
        scale_color_gradient(high = "red",low = 'white',name=NULL,labels=NULL) +
        labs(x='eQTL position',y='eGene position') + 
        ggtitle(time1) +
        theme(legend.position = 'none',legend.margin = margin(0,0,0,0))

ggsave(paste0(time,'_eqtl_pos_3.pdf'),p1,width=2.7,height=2.5)


## 边框粗细
# 估计是基因表达量的图
ggplot(dataPlot, aes(x=time, y=percentage,fill=pattern)) +
    geom_bar(stat="identity", position="stack", aes(fill=pattern)) +
    geom_text(aes(label=paste0(percentage,"%")), position=position_stack(vjust=0.5),size=2.7) + #这里的size是什么单位
    scale_fill_manual(values=mycolor) + theme_bw()+ labs(x=NULL)+
    theme(panel.grid.major = element_blank()) + scale_y_continuous(expand = c(0,0))+
    theme(panel.border = element_rect(fill=NA,color="black", size=1.5, linetype="solid"),
          axis.ticks =element_line(color='black',size=1.5),
          axis.text = element_text(size=8,color = 'black'),
          axis.text.x = element_text(angle = 35,hjust=1),
          axis.title=element_text(size=8,face="plain",color="black"),
          plot.title = element_text(size=8,colour = "black", color = "black"),
          legend.title=element_text(size=8,face="plain",color="black"),
          legend.text =element_text(size=8),
          legend.key.size=unit(0.2,'in'),
          legend.position="bottom"
     )

# sGWAS
mytheme <-   theme(
    axis.title=element_text(size=13,face="plain",color="black"),
    axis.text = element_text(size=10,face="plain",color="black"),
    legend.title=element_text(size=14,face="plain",color="black"),
    strip.text = element_text(size=12,face="plain",color="black"),
    axis.text.x = element_text(hjust = 1, vjust = 0.5,angle = 90),
    panel.grid.major=element_blank(),
    panel.grid.minor = element_blank(),
    panel.background = element_rect(fill="white",colour="black",size=0.4))


# 柱形图翻转
df2$QTL <- factor(df2$QTL,levels=c('missed','sQTL'))
df2$trait_name <- forcats::fct_rev(df2$trait_name)  # 改y轴的顺序
p <- ggplot(data = df2, mapping = aes(x = trait_name, fill = QTL, y = PVE)) + geom_col() + coord_flip(ylim = c(0,1),expand = FALSE)

p1 <- p +
 scale_fill_manual(values=c('grey','#00AFBB')) + 
 labs(y='Proportion of heritability explained by QTLs',x='') + 
 guides(fill=guide_legend(title = NULL,reverse=T)) + 
  theme(
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    axis.text = element_text(color='black'),
    panel.background = element_rect(fill='white')
  )




ggsave('sQTL_PVE_1.pdf')

```



