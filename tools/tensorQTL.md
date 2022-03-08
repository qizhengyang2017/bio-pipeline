```python
indep_df = cis.map_independent(genotype_df, variant_df, cis_df,
                               phenotype_df, phenotype_pos_df, covariates_df)
```

```python
import pandas as pd
import torch
import tensorqtl
from tensorqtl import genotypeio, cis, trans
print(f'PyTorch {torch.__version__}')
print(f'Pandas {pd.__version__}')

# define paths to data
plink_prefix_path = 'GEUVADIS.445_samples.GRCh38.20170504.maf01.filtered.nodup'
expression_bed = 'GEUVADIS.445_samples.expression.bed.gz'
covariates_file = 'GEUVADIS.445_samples.covariates.txt'
prefix = 'GEUVADIS.445_samples'

# load phenotypes and covariates
phenotype_df, phenotype_pos_df = tensorqtl.read_phenotype_bed(expression_bed)
covariates_df = pd.read_csv(covariates_file, sep='\t', index_col=0).T

# PLINK reader for genotypes
pr = genotypeio.PlinkReader(plink_prefix_path)
genotype_df = pr.load_genotypes()
variant_df = pr.bim.set_index('snp')[['chrom', 'pos']]
```