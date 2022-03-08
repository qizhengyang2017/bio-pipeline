~/cotton_fiber/GP/rrBLUP_clumping/run.sh

```sh
#bsub -q q2680v2 -o %J.out -e %J.err "sh run.sh 0.00001"

threshold=$1
mkdir gwas$threshold

# clumping
cd gwas$threshold
pre=/public/home/zyqi/cotton_fiber/gwas/trait_blup_376
for i in FL FS FE FU
do
  mkdir $i
  cd $i
  module load plink/1.9

  plink \
      --bfile $pre/filter2_Q1000_SNPs_joint_376_MAF0.05 \
      --clump-p1 $threshold \
      --clump-r2 0.1 \
      --clump-kb 250 \
      --clump /data/cotton/zyqi/gwas/phe_376/BLUP_${i}_out \
      --clump-snp-field SNP \
      --clump-field Pvalue \
      --out filter2_Q1000_SNPs_joint_376_MAF0.05_clump

  awk 'NR!=1{print $3}' filter2_Q1000_SNPs_joint_376_MAF0.05_clump.clumped >  cotton.valid.snp


  plink \
      --bfile $pre/filter2_Q1000_SNPs_joint_376_MAF0.05 \
      --extract cotton.valid.snp \
      --make-bed \
      --out cotton_clump

  plink --bfile cotton_clump --recodeA --out cotton_clump
  cd ..
done

# 建模
cd ..
for i in FL FS FE FU
do
  Rscript rrBLUP.r $i gwas$threshold
done

cd gwas$threshold
paste FL/accuracy.txt FS/accuracy.txt FE/accuracy.txt FU/accuracy.txt > allTrait_accuracy.txt
```

rrBLUP.r

```R
library(rrBLUP)
library(data.table)
library(caret)

args <- commandArgs(TRUE)
pre <- args[1]
base <- args[2]
# base为不同阈值所在的目录
setwd(paste0(base,'/',pre))

if (pre=='FL') col_index <- 1
if (pre=='FS') col_index <- 2
if (pre=='FE') col_index <- 3
if (pre=='FU') col_index <- 4


genotype <- fread('cotton_clump.raw')

G = as.matrix(genotype[,!c(1:6)])
rownames(G) = genotype$IID
rm(genotype)
# -1 0 1
G <- G-1

impute = A.mat(G,max.missing=0.5,impute.method="mean",return.imputed=T)
rm(G)
Markers_impute2 = impute$imputed

pheno_path <- '~/cotton_fiber/GP/KAML/cotton/data/phenotype/phenotype_withID.txt'
Pheno <- as.matrix(read.table(file =pheno_path, header=TRUE,row.names = 1))


timestart<-Sys.time()
#5折交叉验证，重复3次
set.seed(12345)
traits=1 # 表型数
cycles=3
accuracy = matrix(nrow=cycles, ncol=traits)


for(r in 1:cycles){
  # 5折交叉验证
  Z = 5
  accuracy_1 = matrix(nrow=Z, ncol=traits)
  folds <- createFolds(y=1:376,k=5) # 随机分成5份

  for (i in 1:Z){
      # 训练集
      Pheno_train=Pheno[-folds[[i]],]
      m_train=Markers_impute2[-folds[[i]],]

      # 测试集
      Pheno_valid=Pheno[folds[[i]],]
      m_valid=Markers_impute2[folds[[i]],]
      for (t in 1:traits){
          # 训练集表型
          # yield=Pheno_train[,t] # 改
          yield=Pheno_train[,col_index]

          # FL 预测值
          yield_answer<-mixed.solve(yield, Z=m_train, K=NULL, SE = FALSE, return.Hinv=FALSE)
          pred_yield_valid =  m_valid %*% as.matrix(yield_answer$u)
          pred_yield=pred_yield_valid[,1]+c(yield_answer$beta)

          # 测试集表型
          # yield_valid = Pheno_valid[,t] # 改
          yield_valid = Pheno_valid[,col_index]

          # 计算相关性
          accuracy_1[i,t] <-cor(pred_yield_valid, yield_valid, use="complete" )
      }
  }
  # 列是性状
  accuracy[r,] = apply(accuracy_1,2,mean)
}
timeend<-Sys.time()
runningtime<-timeend-timestart
print(runningtime)

#colnames(accuracy) <- c('FL','FS','Enlongation','UI')
colnames(accuracy) <- c(pre)
mean(accuracy)
write.table(accuracy,'accuracy.txt',quote=F,row.names = F)
```



