## 安装画图R包
2022年01月16日
new1环境（一开始用的new环境，R版本是4.0.5）
```shell
# conda create -n predictor r-base=4.1.0 r-irkernel r-tidyverse jupyterlab r-languageserver python=3.7.4 #有冲突

# 用现有的new1环境，r-base=4.1.1
conda install -c conda-forge r-ggthemes r-vcd r-upsetr r-lemon r-sm r-viridis r-ggpmisc r-ggridges -y

conda install -c conda-forge r-readxl -y
conda install -c conda-forge r-ggpubr -y

conda install -c bioconda bioconductor-edger bioconductor-ensdb.hsapiens.v86 bioconductor-fgsea r-ggbiplot bioconductor-org.hs.eg.db bioconductor-pigengene bioconductor-reactomepa -y
```

conda search r-base
jupyter kernelspec list

## 添加内核
添加R内核到jupyterlab
IRkernel::installspec(name='ir_new1',displayname='R (new1)')

添加python内核到jupyterlab
python -m ipykernel install --user --name python3_new1 --display-name "Python3 (new1)"

## 安装python包
2022年01月17日
new1环境
```shell
## 带上版本号会有冲突，Found conflicts! Looking for incompatible packages.
# conda install numpy=1.16.4 numpydoc=0.9.1 scipy=1.3 scikit-image=0.15.0 scikit-learn=0.21.2 pandas=0.24.2 seaborn=0.9.0 ipywidgets=7.5.1 voila

conda install numpy numpydoc scipy scikit-image scikit-learn pandas seaborn ipywidgets voila
```