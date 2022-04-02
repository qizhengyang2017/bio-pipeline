缺失值

```R
test <- c(1,NA,3,2)
test[test==2]
```

这样操作结果里存在缺失值





## R4.05与R3.6不同的地方



### 3.6

3.6要check.names。4不知道

genotype_df <- data.frame(SNP=rownames(genotype1),genotype1,stringsAsFactors = F,check.names = F)



as.data.frame不会改列名

plot_data <- as.data.frame(plot_data)







## dplyr

data.frame will also be data.frame after `select`; not become tibble.
