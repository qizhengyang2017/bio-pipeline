## 传参
```R
args <- commandArgs(TRUE)
pre <- args[1]
```


## 整理分类变量
https://mp.weixin.qq.com/s/k51GNMPycAr0PmSsgxK_pQ

```R
install.packages("forcats")
library(forcats)

gender <- factor(c("female", "male", "male", "f", "m", "a"))
gender
new_gender <- fct_collapse(gender, Female = c("female", "f"), Male = c("male", "m"), NULL = "a") 
new_gender

```

## 字符串
```R
sapply(strsplit(f$InTerm_InList,'\\/'),function(x) x[1]) # str_split也可

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

```R
# 多个向量取交集
genes <- Reduce(intersect, list(A, B, C, D ...))
```

## pca
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