##  对profiles进行wilcox检验

https://mp.weixin.qq.com/s/laQtJl8LeyxA4BGjr-HewA

```R
# 四个参数，按顺序分别为：
# - profiles matrix file
# - sample group file 
# - outfile name
# - threads number（默认为服务器总线程-10）

Args <- commandArgs(T)

library(parallel)

# Initiate cluster
if(is.na(Args[4])) {
no_cores <- detectCores() - 10
} else {
no_cores <- as.integer(Args[4])
}
cl <- makeCluster(no_cores)

data <- read.table(Args[1],head=T,row.names=1,sep='\t')
group <- read.table(Args[2],head=T,sep='\t')

# 找出profiles中每列代表的样本所属的组
col_group1 <- colnames(data) %in% sub('-','.',paste(group$Sample[group$Group==1],'.rpkm',sep=''))
col_group2 <- colnames(data) %in% sub('-','.',paste(group$Sample[group$Group==2],'.rpkm',sep=''))

# 对单个基因进行wilcox检验，并输出统计检验结果，输出格式如下：
#     geneName,pvalue,group1Median,group2Median,direction
wilcox_fun <- function(data,col_group1,col_group2){
g1 <- as.numeric(data[col_group1])
g2 <- as.numeric(data[col_group2])
# 执行wilcox检验
stat <- wilcox.test(g1,g2,paired = FALSE, exact=NULL, correct=TRUE, alternative="two.sided")
if(is.na(stat$p.value)){
    stat$p.value <- 1
}
# 对有统计学意义的基因进行判断，是上调"up"还是下调"down"或者是不变"-"（对于组2，即不吃药组）
if(stat$p.value < 0.1  & median(g1) < median(g2)){
    G12 <- c(ifelse(is.na(stat$p.value),1,stat$p.value),median(g1),median(g2),'down')
}
else if(stat$p.value < 0.1  & median(g1) > median(g2)){
    G12 <- c(ifelse(is.na(stat$p.value),1,stat$p.value),median(g1),median(g2),'up')
}
else if(stat$p.value < 0.1  & median(g1) == median(g2)){
    G12 <- c(ifelse(is.na(stat$p.value),1,stat$p.value),median(g1),median(g2),'-')
}
else{
    G12 <- c()
}
G12
}

statOut <- parApply(cl,data,1,wilcox_fun,col_group1,col_group2)
stopCluster(cl)
# 删除为NULL的列表元素
for(i in names(statOut)){
if(is.null(statOut[[i]])){
    statOut[[i]] <- NULL
}
}

# 将结果写入文件中
if(!is.null(statOut)){
# 转换成数据框
statOut <- as.data.frame(t(as.matrix(as.data.frame(statOut))))
colnames(statOut) <- c('pvalue','group1Median','group2Median','direction')
# 写入文件
write.table(statOut,Args[3],sep = '\t',row.names = T,col.names = T,quote = F)
}
```

