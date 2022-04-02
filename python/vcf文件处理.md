

只保留vcf文件中的GT信息

~/cotton_fiber/4_panel_genome_data/comm_vcf

```python
import sys
print('##fileformat=VCFv4.2')
print('##FORMAT=<ID=GT,Number=1,Type=String,Description="Genotype">')
with open(sys.argv[1]) as infile:
    for line in infile:
        line = line.strip()
        if line.startswith('#'):
            print(line)
        else:
            line = line.split('\t')
            line[5] = '.'
            line[6] = '.'
            line[7] = '.'
            line[8] = line[8].split(':')[0]
            for i in range(9,len(line)):
                line[i] = line[i].split(':')[0]
            print('\t'.join(line))

```

