library(sommer)
library(data.table)
library(lme4)
library(caret)


dat = fread("phenotype_withID.txt")
dat = dat[,1:2]
dat$ID = as.factor(as.character(dat$ID))
dat <- as.data.frame(dat)

M012 = fread("filter2_Q1000_SNPs_joint_376_MAF0.05.raw")
G = as.matrix(M012[,!c(1:6)])
rownames(G) = M012$IID
Gmat = A.mat(G-1)

traits=1
cycles=10 # 重复10次
accuracy=matrix(nrow=cycles,ncol = traits)
set.seed(888)
for(r in 1:cycles){

  folds <- createFolds(y=dat$FL,k=10)

  Z = 10
  MSE=rep(0,Z) #建立一个向量储存结果
  for(i in 1:Z){
    fold_test <- dat[folds[[i]],]   #取folds[[i]]作为测试集
    fold_train <- dat[-folds[[i]],] 
    mod.mm <- mmer(FL ~ 1, 
                  random=~vs(ID,Gu=Gmat),
                  rcov=~units,
                  data=fold_train,verbose = FALSE)
    blup = as.data.frame(mod.mm$U$`u:ID`)
    MSE[i] = cor(blup[fold_test$ID,],dat[fold_test$ID,2],use="complete")
    
  }
  num <- mean(MSE)
  accuracy[r,1]<- num
}
accuracy
mean(accuracy)