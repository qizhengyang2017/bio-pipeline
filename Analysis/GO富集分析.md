## GO富集分析
~/work/enrichment/tomato

#软件
clusterprofiler：直接在R终端里安装真是坑（mac, conda环境 r）。编译半天。在R terminal里安装的包，conda能管理到吗？ #questions 

### buildGOmap的作用
直接注释和间接注释：
GO富集分析中的间接注释，增加父层级。
If genes are annotated by direction annotation, it should also annotated by its ancestor GO nodes (indirect annation). If user only has direct annotation, they can pass their annotation to `buildGOmap` function, which will infer indirection annotation and generate a `data.frame` that suitable for both [enricher()](https://rdrr.io/pkg/clusterProfiler/man/enricher.html) and [gseGO()](https://rdrr.io/pkg/clusterProfiler/man/gseGO.html).

[Vignette](https://yulab-smu.top/biomedical-knowledge-mining-book/clusterprofiler-go.html)


```r
go2gene1 <- buildGOmap(go2gene)

# 可以生成description，
des <-  go2term(go2gene1$GO)
# BP，MF，CC这些信息
ont <- go2ont(go2gene1$GO)
```

没有orgDB，只能用enricher做富集，`gofilter`函数指定层级
[函数说明]( https://bioconductor.org/packages/release/bioc/manuals/clusterProfiler/man/clusterProfiler.pdf)