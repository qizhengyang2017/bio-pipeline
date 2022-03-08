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


