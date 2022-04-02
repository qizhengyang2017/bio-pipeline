## 常用命令

```bash
# 查看jupyter内核
jupyter kernelspec list

#安装jupyter 插件需要先装nodejs
conda install -c conda-forge nodejs

# 移除内核
jupyter kernelspec remove ir
```

## 安装内核

为什么有的内核路径在.local有的在anaconda环境？



用集群上的的hotspot环境测试，该环境下没有使用Jupyter

```bash
conda install r-base=3.6 r-irkernel jupyterlab python=3.7 -y
```

会自动在该环境中配置python和r的内核，如下

```
/public/home/zyqi/anaconda3/envs/hotspot/share/jupyter/kernels/:
total 1.0K
drwxr-xr-x 2 zyqi MJWang 4.0K Mar 28 22:39 python3
drwxr-xr-x 2 zyqi MJWang 4.0K Mar 28 22:39 ir
```



用这个命令**什么都不指定**,会在.local下配置R内核

```
> IRkernel::installspec()
[InstallKernelSpec] Installed kernelspec ir in /public/home/zyqi/.local/share/jupyter/kernels/ir
```





## 网页jupyter

优点：

- 插件
- merge selected cell







## vsocde jupyter

优点：

- format cell
- whitespace
- 变量选择高亮



缺点：

- 为什么不多一个join cell 的标志





watching

开发过程

https://github.com/microsoft/vscode-jupyter/issues





vscode

https://github.com/microsoft/vscode/issues
