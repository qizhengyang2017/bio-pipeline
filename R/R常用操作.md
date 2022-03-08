读取excel表格

```R
library(readxl)
metadata  <- data.frame(read_excel(paste0(suppTableDir,"Supplementary Tables.xlsx"),sheet = 1))
```



group_by之后字符串连接

```R
snp_select %>% group_by(trait,gene) %>% summarise(chr=chr,time=paste(time,collapse=','))

# group_by里的变量要写全
snp_select <- snp_select %>% group_by(trait,gene,lead_SNP,chr,start,end) %>% summarise(time=paste(time,collapse=','))
```







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



tibble

```R
tibble(
  x = rnorm(n = 100, mean = 0, sd = 1)
)
```



传参

```R
args <- commandArgs(TRUE)
pre <- args[1]
```



字符串

```R
sapply(strsplit(f$InTerm_InList,'\\/'),function(x) x[1]) # str_split也可

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

