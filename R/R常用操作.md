因子处理

https://mp.weixin.qq.com/s/k51GNMPycAr0PmSsgxK_pQ

```R
install.packages("forcats")
library(forcats)

gender <- factor(c("female", "male", "male", "f", "m", "a"))
gender
new_gender <- fct_collapse(gender, Female = c("female", "f"), Male = c("male", "m"), NULL = "a") 
new_gender

```



ifelse

```R
x <- c(1,2,NA,NA,5)
ifelse(is.na(x),0,x)
#[1] 1 2 0 0 5
```



字符串操作

```R
sapply(strsplit(f$InTerm_InList,'\\/'),function(x) x[1]) # str_split也可

```



## 其他

读入R data

```
load('weights_4D/Ghir_D13G025160.wgt.RDat')
```



传参

```R
args <- commandArgs(TRUE)
pre <- args[1]
```





多个向量取交集
```R
genes <- Reduce(intersect, list(A, B, C, D ...))
```







常用操作

```R
ls() # 列出当前变量

options(repr.plot.width=3, repr.plot.height=3)
```





## R包操作

```R
(.packages()) # 列出已加载的包
detach("package:tidyverse") #detach

# 安装指定位置
install.packages('isoband',lib='/TJPROJ6/SC/personal_dir/qizhengyang/R/library')
remove.packages(c("infercnv"), lib=file.path("/Library/Frameworks/R.framework/Versions/3.6/Resources/library"))
library(SoupX,lib.loc = '/TJPROJ6/SC/personal_dir/qizhengyang/R/library')


#查看libPath
.libPaths()
# 指定libPath
.libPaths(c("/TJPROJ6/SC/personal_dir/qizhengyang/R/library","/TJPROJ5/SC/software/miniconda3/envs/scrna_py3/lib/R/library"))


# 其他方式装包

devtools::install('github/ThreeDRNAseq/') # 本地安装


library(devtools)
devtools::install_github('broadinstitute/infercnv')
devtools::install('celltalker',lib='/TJPROJ6/SC/personal_dir/qizhengyang/R/library')



# 查看包
packageVersion('Seurat')

packageDescription("Seurat")

browseVignettes()

help(package = "Seurat")
```

