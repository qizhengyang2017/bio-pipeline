# Assessment of Prediction Accuracy
#library(caret) # cross-validation
library(BGLR)
library(data.table)

impute.mean <- function(W) {
    n <- nrow(W)
    m <- ncol(W)
    for (i in 1:m) {
        Wi <- W[, i]
        missing <- which(is.na(Wi))
        W[missing,i] <- mean(Wi,na.rm = T)
        }
        W
    }

bayes_fun <- function(phenotype,Markers,model){
  bayes <- BGLR(phenotype,ETA = list(list(X=Markers,model=model)),
                 nIter = 1000,burnIn = 500,thin = 5,saveAt = "",
                 S0 = NULL,R2 = 0.5, weights = NULL,verbose = TRUE,
                 rmExistingFiles = TRUE, groups=NULL)

  bayes_pred <- bayes$yHat
  return(list(predict_value=bayes_pred,
              phenotype=phenotype,
              r=cor(bayes_pred,phenotype)))
}


dat = read.table("phenotype_withID.txt",header=T,stringsAsFactors = F)
M012 = fread("filter2_Q1000_SNPs_joint_376_MAF0.05.raw")
G = as.matrix(M012[,!c(1:6)])
rownames(G) = M012$IID

G <- impute.mean(G)

# 就先做一次评估，因为计算速度太慢了

set.seed(12345)
y.trn <- dat[,2]
n <- length(y.trn)
vv <- sample(1:n,round(n/10))   # 抽取20%作为验证群体
y.tst <- y.trn[vv] #真实表型
y.trn[vv] <- NA

# bayes LASSO
bl <- bayes_fun(y.trn,G,model="BL")
bl[['tst.index']] <- vv
saveRDS(bl, "cv.BL.rds")






## bayesA
bayesA <- bayes_fun(y.trn,G,model="BayesA")
bayesA[['tst.index']] <- vv
saveRDS(bayesA, "cv.bayesA.rds")

## bayesB
bayesB <- bayes_fun(y.trn,G,model="BayesB")
bayesB[['tst.index']] <- vv
saveRDS(bayesB, "cv.bayesB.rds")

## bayesC
bayesC <- bayes_fun(y.trn,G,model="BayesC")
bayesC[['tst.index']] <- vv
saveRDS(bayesC, "cv.bayesC.rds")

## brr
brr <- bayes_fun(y.trn,G,model="BRR")
brr[['tst.index']] <- vv
saveRDS(brr, "cv.BRR.rds")



