## gff添加gene name

~/ga/locus_plot

gff文件添加gene name

```python
# python addname.py change.Chr_genome_final_gene_deleteContig.gtf > A2.gtf
import re
import sys
with open(sys.argv[1]) as f:
    for line in f:
        line = line.strip()
        field = line.split('\t')
        attribute = field[8]
        gene_name = re.findall(r'gene_id "(.+?)";',attribute)
        gene_name = ''.join(gene_name)
        gene_name = 'gene_name "' + gene_name + '"'
        #print(gene_name)
        pattern = re.compile(r'gene_name ""')
        out = re.sub(pattern, gene_name, attribute)
        out = out + ' gene_type "unknown";'
        # print(attribute)
        # print(out)
        # print(field[0:8])
        if field[2] == 'gene' or field[2] == 'transcript' or field[2] == 'exon':
            print('\t'.join(field[0:8]) + '\t' + out)
```



## extract ensembl ID

```python
#!/usr/bin/env python

# python chr.py Homo_sapiens.GRCh38.99.gtf gene.tsv
import sys
import os


def read_gene(gtf):
    gene = []
    with open(gtf) as lines:
        for line in lines:
            if 'gene_name' in line:
                t = line.strip().split('\t')
                gene_name = t[8].split(';')[2].replace('gene_name ', '')
                gene_name = eval(gene_name) # 去引号
                gene_id = t[8].split(';')[1].replace('gene_id ', '')
                gene_id = eval(gene_id).replace('gene:','')
                gene.append([gene_id, gene_name])
    #gene_uniq = []
    #[gene_uniq.append(i) for i in gene if not i in gene_uniq] # 列表推到式，去重。慢！

    return gene


gene = read_gene(sys.argv[1])
f = open(sys.argv[2], 'w')
for i in range(len(gene)):
    j = gene[i]
    f.write(j[0] + '\t' + j[1] + '\n')
f.close()

# cat Bos_taurus_gene.tsv|sort|uniq > Bos_taurus_gene_uniq.tsv

```

## add ensembl ID

/Users/zhengyangqi/memory/其他文件/2020年07月10日/注释/add_ensembl_id

```python
#  python trans.py Bos_taurus_gene_uniq.tsv Cluster_0_diff_significant.xls out1.xls

import sys

ens_sym = sys.argv[1]
input_diff = sys.argv[2]
output_diff = sys.argv[3]

with open(ens_sym) as f:
	name = {}
	for line in f:
		line = line.strip().split('\t')
		name[line[1]] = line[0]
#print(name)

with open(input_diff) as f:
	next(f) # skip first line

	gene_info = []
	for line in f:
		line = line.strip().split('\t')
		try:
			gene_id = name[line[0]]
			gene_info.append([gene_id,line[0],line[6],line[2],line[1],line[5],line[3],line[4]])
		except KeyError:
			if line[0].startswith('ENSBTA'): # 没有ensembl ID丢弃
				gene_id = line[0]
				gene_info.append([gene_id,line[0],line[6],line[2],line[1],line[5],line[3],line[4]])
		

f = open(output_diff, 'w')
f.write('Gene\tGene_name\tcluster\tavg_logFC\tp_val\tp_val_adj\tpct.1\tpct.2\n')
for i in range(len(gene_info)):
    j = gene_info[i]
    f.write(j[0] + '\t' + j[1] + '\t'+ j[2] + '\t' + j[3] + '\t' + j[4] + '\t' + j[5] + '\t'+j[6] + '\t' + j[7] + '\n')
f.close()


```



## gff添加转录本ID

~/database/deyang_genome_female_sgRNA

Parent=Dka_Contig00001G000010.1;ID=Dka_Contig00001G000010.1.exon.1;

```python
out = open('chr_EVM.final.gene.addID.gff3', 'w')
with open ('chr_EVM.final.gene.gff3') as f:
    exon_number = 0
    CDS_number = 0
    utr5p_number = 0
    utr3p_number = 0
    for line in f:
        line = line.strip()
        field = line.split()
        attribute = field[8]
        parent = attribute.split(';')[0][7:]
        if field[2] == 'gene':
            out.write(line + '\n')
        elif field[2] == 'mRNA':
            out.write(line + '\n')
            exon_number = 0
            CDS_number = 0
            utr5p_number = 0
            utr3p_number = 0           
        elif field[2] == 'exon':
            exon_number = exon_number + 1
            exon_id = parent + '.exon.' + str(exon_number)
            out.write(line + 'ID=' + exon_id + ';' + '\n')
        elif field[2] == 'CDS':
            CDS_number = CDS_number + 1
            CDS_id = parent + '.CDS.' + str(CDS_number)
            out.write(line + 'ID=' + CDS_id + ';' + '\n')
        elif field[2] == 'five_prime_UTR':
            utr5p_number = utr5p_number + 1
            utr5p_id = parent + '.utr5p' + str(utr5p_number)
            out.write(line + 'ID=' + utr5p_id + ';' + '\n')
        elif field[2] == 'three_prime_UTR':
            utr3p_number = utr3p_number + 1
            utr3p_id = parent + '.utr3p' + str(utr3p_number)
            out.write(line + 'ID=' + utr3p_id + ';' + '\n')
out.close()

```

