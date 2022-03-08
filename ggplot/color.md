## 颜色
```R
library(RColorBrewer)
display.brewer.all()
color1 <- brewer.pal(6,"Blues")[2:6]
show_col(color1)

# 颜色梯度
color <- colorRampPalette(rev(c("#ff0000", "white")))(100)
```
