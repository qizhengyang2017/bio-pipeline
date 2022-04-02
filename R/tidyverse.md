## group_by之后字符串连接

```R
snp_select %>% group_by(trait,gene) %>% summarise(chr=chr,time=paste(time,collapse=','))

# group_by里的变量要写全
snp_select <- snp_select %>% group_by(trait,gene,lead_SNP,chr,start,end) %>% summarise(time=paste(time,collapse=','))
```



## 读取excel表格

```R
library(readxl)
metadata  <- data.frame(read_excel(paste0(suppTableDir,"Supplementary Tables.xlsx"),sheet = 1))
```



tibble

```R
tibble(
  x = rnorm(n = 100, mean = 0, sd = 1)
)
```



```R
# 使用％in％运算符按多个条件过滤（确保字符串匹配）
df %>%
 filter(relationship %in% c(" Unmarried", " Wife"))
```

