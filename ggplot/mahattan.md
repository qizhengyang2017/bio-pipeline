曼哈顿叠加图

1. 找出需要标注的SNP
2. 标注 ~/work/twas_plot

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

p + guides(fill = "none",color= "none",shape=guide_legend(title = NULL)) + 
    theme(
        legend.position = 'right',
        legend.title=element_text(size=13,face="plain",color="black"),
        legend.key=element_rect(fill='transparent')
    )

```

## 单个位点曼哈顿图
```R
options(repr.plot.width=4, repr.plot.height=2.2)
a2 <- filter(a1,Position > 82.5 & Position < 87.5)

a2 <- filter(a1,Position > 84.8 & Position < 86.7)

ggplot(a2, aes(Position, logP))+
    geom_point(aes(color=color),size=1) + 
    scale_color_manual(values=color) + 
    mytheme +
    ylab(expression(~-log[10]~'(P)')) + 
    scale_y_continuous(expand = expansion(mult=c(0,0.05))) +
    geom_hline(yintercept = t2, color = c('black'), size = 0.35,linetype=2)
```


## 单条染色体曼哈顿图
/data/cotton/zyqi/Ga/Ga_GWAS_new/chr05_hotspot_region
```R
ggplot(a2, aes(Position, logP))+geom_point(color='#E69F00',size=1) +  
    theme_classic() +
    ylab(expression(~-log[10]~'(P)')) + 
    xlab('Chr05 (Mb)') +
    geom_hline(yintercept = t2, color = c('black'), size = 0.35,linetype=2) +
    scale_y_continuous(expand = expansion(mult=c(0,0.05)))+
    theme(legend.position='none',
         axis.title=element_text(size=13,face="plain",color="black"),
         axis.text=element_text(size=13,face="plain",color="black")) +
    scale_x_continuous(expand = c(0.01,0))

# ggsave('hot5_5.pdf',width=2.2,height=1.8)

ggsave('hot6_allchr.pdf',width=4,height=2)

```



