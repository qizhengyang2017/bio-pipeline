

## PCA



```R
library(tidyverse)

f <- read.table('SC-OG.17520OG.FPKM.txt',header=T,stringsAsFactors = F,row.names = 1)

f1 <- f[3:nrow(f),]
f1 <- log1p(f1)
pr <- prcomp(f1)

percentVar <- pr$sdev^2 / sum( pr$sdev^2)
percentVar[1:2]


pca2comp <- pr$rotation[,1:2]
pca2comp <- as.data.frame(pca2comp)

color <- unlist(f[1,])

pca2comp$color <- as.factor(color[rownames(pca2comp)])

shape <- unlist(f[2,])
pca2comp$shape <- as.factor(shape[rownames(pca2comp)])

p <- ggplot(pca2comp,aes(PC1,PC2,color=color,shape=shape)) + geom_point() + theme_bw() + 
    theme(
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    axis.text = element_text(color='black') 
)

library(eoffice)
topptx(p,"SC-OG_pca_log.pptx",width=4,height=3)
ggsave('SC-OG_pca_log.pdf',height=3,width=4)

```



## 测试lm4包

```R
library(lme4)

data(sleepstudy)
mod1a = lmer(Reaction ~ Days + (1 | Subject), data=sleepstudy)
coef(summary(mod1a))
summary(mod1a)

# 提取方差
var.trans = lme4::VarCorr(mod1a)

var.trans$Subject

attr(var.trans,'sc')^2
```

