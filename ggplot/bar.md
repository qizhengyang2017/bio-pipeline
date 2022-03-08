## 柱形图
```R
# color <- c('#2166ac','#b2182b')
color <- c('#999999','#E69F00')

options(repr.plot.width=2.5, repr.plot.height=2.2)
f_long %>% ggplot(aes(stage,number,fill=type)) +
    geom_col(position=position_dodge2(),colour = 'black',size=0.2) + 
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

## 柱形图翻转
```R
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
