[[@sammut2021]]
两个网址
文献中给的网址
https://github.com/cclab-brca/neoadjuvant-therapy-response-predictor
全是R代码，像是一个画图的代码

上面代码库的README中给出了：
The predictor machine learning code is currently hosted at:
https://github.com/micrisor/NAT-ML
这里似乎没有feature extraction的代码
文章选择的feature
```
{'other': ['Trial.ID',
  'resp.pCR',
  'resp.Chemosensitive',
  'resp.Chemoresistant',
  'RCB.score',
  'RCB.category'],
 'clin': ['Age.at.diagnosis',
  'Histology',
  'ER.status',
  'HER2.status',
  'LN.at.diagnosis',
  'Grade.pre.chemotherapy',
  'Size.at.diagnosis'],
 'clinplus': ['ER.Allred'],
 'digpath': ['median_lymph_KDE_knn_50'],
 'dna': ['All.TMB',
  'Coding.TMB',
  'Expressed.NAg',
  'CodingMuts.PIK3CA',
  'CodingMuts.TP53',
  'CIN.Prop',
  'HLA.LOH',
  'HRD.sum'],
 'rna': ['STAT1.ssgsea.notnorm',
  'GGI.ssgsea.notnorm',
  'ESC.ssgsea.notnorm',
  'PGR.log2.tpm',
  'ESR1.log2.tpm',
  'ERBB2.log2.tpm',
  'CytScore.log2',
  'Swanton.PaclitaxelScore',
  'TIDE.Dysfunction',
  'TIDE.Exclusion',
  'Danaher.Mast.cells'],
 'chemo': ['Chemo.NumCycles',
  'Chemo.first.Taxane',
  'Chemo.first.Anthracycline',
  'Chemo.second.Taxane',
  'Chemo.second.Anthracycline',
  'Chemo.any.Anthracycline',
  'Chemo.any.antiHER2']}
  ```