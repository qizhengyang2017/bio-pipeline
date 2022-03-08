## 安装


集群目录
~/cotton_fiber/GP/KAML

本地目录
~/work_new/KAML

module load R/microsoft-r-open-MRO-3.5.1


```R
.libPaths("/public/home/zyqi/R/MRO_lib")
install.packages("devtools") #安装失败
```

本地源码包安装，成功！
```sh
module load R/microsoft-r-open-MRO-3.5.1
export R_LIBS_USER=/public/home/zyqi/R/MRO_lib
git clone https://github.com/YinLiLin/KAML
R CMD INSTALL KAML
```

## 注意
_**Note again:**_ _**`KAML`**_ has no function for adjusting the order of individuals. So please make sure the same order of individuals between phenotype and genotype.


## ref
#KAML 的参考文档
https://github.com/YinLiLin/KAML