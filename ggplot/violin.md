## 小提琴图+箱线图
```R
p <- ggplot(e1[[1]],aes(genotype,exp)) +
        geom_violin(aes(fill=genotype)) +
        geom_boxplot(width=0.1) +
        ylab('log1p(FPKM)') +
        theme_classic() +
        myfont +
        scale_fill_manual(values=col[2:1]) +
        scale_x_discrete(labels = c(e1[[2]],e2[[3]])) +
        xlab(eqtl) + ggtitle(paste0('P =',e1[[4]]))

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
    

p <- p + theme(legend.background=element_roundrect(color="#808080", linetype=2))

p + annotate("text", x = 1:5, y = 45, label = c(e1[[4]],e2[[4]],e3[[4]],e4[[4]],e5[[4]]),size=3) + theme(legend.position = c(0.77,0.77))
```


