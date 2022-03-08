参考这个目录
~/ga/coloc_tensorQTL/locus_plot_causalSNP_1

---

## 早期目录
~/cotton_fiber/locus_plot
使用gtex环境

1. gff2转成gtf用的是python包。bioinfokit。
```python
from bioinfokit.analys import gff
gff.gff_to_gtf(file="Athaliana_167_TAIR10.gene_chr1.gff3")
```

2. 用的当前目录下的annotation脚本。加了下面两句话。

```
$diff annotation.py pyqtl-master/qtl/annotation.py
443,444d442
<                         if 'gene_type' not in attributes:
<                             attributes['gene_type'] = 'unknown'
```

3. 标准化后的表达量去掉了不在染色体上的基因





其他软件

LocusZoom [[@georges2021]] 
http://locuszoom.org/





