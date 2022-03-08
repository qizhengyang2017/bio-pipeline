基因型文件转hmp格式，贺鑫写的代码

```python
from collections import Counter
import pandas as pd
allels = []
with open("All_UplandMAGIC_Parents11_RILs550_mergedSNPs_filter2.txt")as f:
    head = f.readline()
    for i in f:
        i = i.split()
        ref = i[2][0]
        seq = "".join(i[3:])
        counter = Counter(seq)
        keys = list(counter.keys())
        keys.remove(ref)
        try :
            keys.remove("N")
        except ValueError as e:
            pass
        allels.append(ref+"/"+keys[0][0])
df = pd.read_table("All_UplandMAGIC_Parents11_RILs550_mergedSNPs_filter2.txt")
df.pop("Refs")
samples = list(df.iloc[:,2:].columns)
col = "   strand  assembly        center  protLSID        assayLSID       panel   QCcode".split()
for c in col:
    df[c] = "NA"
df["rs"] = df["Chr"].astype(str) +"_"+ df["Loci"].astype(str)
df["allels"] = allels
head = "rs      allels Chr   Loci     strand  assembly        center  protLSID        assayLSID       panel   QCcode".split()
head.extend(samples)
df.loc[:,head].to_csv("All_UplandMAGIC_Parents11_RILs550_mergedSNPs_filter2.hmp",index=False,sep="\t")

```



