## 散点图+拟合线
```R
p2 <- ggplot(p_group, aes(x = Ghir_D09_35396780, y = FE, color = Ghir_A10_58433793)) + 
    geom_point() + 
    geom_smooth(method = "lm", se = FALSE) +
    scale_color_manual(values = mypalette) +
    scale_x_continuous(breaks=c(0,2),labels=c('CC','GG'),expand=c(0.1,0.1)) +
    theme_classic2() +
    mytheme +
    theme(legend.position = 'top') + ylab('FE (%)')
```

## eqtl dotplot
```R
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
```


