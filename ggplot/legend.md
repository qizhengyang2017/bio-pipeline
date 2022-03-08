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


