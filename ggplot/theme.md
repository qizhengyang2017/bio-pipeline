## 主题

```R
theme(panel.border = element_rect(fill=NA,color="black", size=1, linetype="solid"),
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank(),
      axis.ticks =element_line(color='black',size=1),
      axis.text = element_text(size=8,color = 'black'),
      axis.title=element_text(size=8,face="plain",color="black"),
      plot.title = element_text(size=8,colour = "black", color = "black"),
      legend.title=element_text(size=8,face="plain",color="black"),
      legend.text =element_text(size=8),
      legend.key.size=unit(0.2,'in')
     )






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




plotAnnoBar(peakAnnoList) + theme(panel.grid.major = element_blank()) + scale_y_continuous(expand = c(0,0))+ 
theme(panel.border = element_rect(fill=NA,color="black", size=1.5, linetype="solid"),
      axis.ticks =element_line(color='black',size=1.5),
      axis.text = element_text(size=16,color = 'black'),
      axis.title=element_text(size=16,face="plain",color="black"),
      plot.title = element_text(size=16,colour = "black", color = "black"),
      legend.title=element_text(size=16,face="plain",color="black"),
      legend.text =element_text(size=14),
      legend.key.size=unit(0.2,'in')
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
```
