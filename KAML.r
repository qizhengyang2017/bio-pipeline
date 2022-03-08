# path: ~/cotton_fiber/GP/KAML/cotton



DT = read.table("data/phenotype.txt",header=T)


set.seed(12345)
y.trn <- DT
vv <- sample(rownames(DT),round(nrow(DT)/10))   # 抽取20%作为验证群体（被预测）
y.trn[vv,"FL"] <- NA
head(y.trn)

write.table(y.trn,'FL_train.txt',sep='\t',quote=F,row.names = F)

library(KAML)
mykaml <- KAML(pfile="FL_train.txt", pheno=1, gfile="data/cotton",cpu=20)
saveRDS(mykaml,"mykaml.rds")


blup <- read.table('KAML.FL.pred.txt',header=T)

accuracy <- cor(blup[vv,],DT[vv,]$FL)

cat(paste("accuracy: ", accuracy))