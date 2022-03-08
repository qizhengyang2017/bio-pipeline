## 折线图

```R
ggplot(f,aes(x=Start,y=Nums)) +
    geom_line(color='blue') + 
    scale_x_continuous(breaks = chr$label1, labels = chr$chr_name, expand = c(0, 0)) + 
    geom_vline(xintercept = chr$label, color = c('gray'), size = 0.35,linetype=2) +
    geom_text(mapping=aes(x=label1,y=1600,label=chr_name),data=chr, size=3,color='black',fontface='bold') +
    labs(x=NULL,y=NULL) +
    scale_y_continuous(expand=expansion(mult = c(0.05, 0.1))) +
    mytheme
```
