王翠颖师姐给我的诺禾的培训资料

/Users/zhengyangqi/工作时期/其他文件/集群和语言资料-王翠颖/5-python培训/python练习文档说明.doc





1，给一段碱基序列seq，和kmer长度n。将给的碱基序列seq切成长度为n的kmer。
代码：

```python
#!/usr/bin/env python    
import sys      
infile=open(sys.argv[1],”r”)   
seq=infile.readline().strip()  
n=int(infile.readline().strip())  
for i in range(len(seq)-n+1):     
	print seq[i:i+n]    
```

- 程序的第一行，这个没什么特别的意思，相当于perl中的#！/usr/bin/perl
- 程序的第二行，##python中sys.argv[1]是传入的第一个参数，sys.argv[0]是程序本身，和perl有点区别，perl中$ARGV[0]是传入的第一个参数。”r”表示的是读的方式打开
- 程序中的第三行，readline()是读一行，strip()相当于perl中的chomp。 这句就相当于先从infile中读一行出来，然后对读出来的内容进行类似perl中的chomp操作，去掉换行符。
- 程序第四行，和第三行差不多，只不过多了一个int()函数，这个是将读出来的内容转换成int类型。
- 第5行，是一个for循环，range()函数，是生成一个列表，比如range(5)生成的是一个[0,1,2,3,4]的列表。
- 第6行，是输出切出来的kmer，其中的seq[i:i+n]就是切kmer的意思，是将seq的第i个元素到第i+n个元素切出来。











2，给出一段碱基序列，求出该段碱基序列的反向互补序列。
代码：

```python
#!/usr/bin/env python
import sys
infile=open(sys.argv[1])
seq=infile.readline().strip()
dic={'A':'T','T':'A','G':'C','C':'G'}
print ''.join([dic[x] for x in seq])[::-1] 
```
- 前面4行和第一个程序一样，第一行是声明python，第二行是导入sys模块，第三行是打开输入文件，第四行是读打开的文件的一行，并去掉读入的内容中的换行符。第5行是声明一个字典，相当于perl中的hash，模式是’key’:’value’ 
- 第6行是求反向互补，这一行比较复杂，首先是 dic[x] for x in seq这一句是去seq字符串中每一个字符，然后取这个字符dic字典中的value值。这个就是求到了seq的互补序列的列表形式，比如开始的时候seq=”ATGC”,那么[dic[x] for x in seq]得到的结果是[‘T’,’A’,’C’,’G’]这么一个列表。’’.join([dic[x] for x in seq])这步得到的就是”TACG”。最后是后面的[::-1]这个就是取反向的意思，得到的结果就是”GCAT”。







3，给一段碱基序列seq，和kmer长度n。将给的碱基序列seq切成长度为n的kmer。统计每个kmer出现的次数，将结果输出出来。输出的格式：左边是kmer序列，右边是这个kmer在碱基序列中出现的次数。

```python
#!/usr/bin/env python
import sys
infile=open(sys.argv[1])
seq=infile.readline().strip()
k=int(infile.readline().strip())
dic={}
for i in range(len(seq)-k+1):
    dic[seq[i:i+k]]=dic.get(seq[i:i+k],0)+1
for j in dic:
print j,dic[j]
```
- 前面5行都和前面的差不多，都是打开文件，读文件，去换行符。
- 第6行是声明一个空字典，相当于perl中的哈希。
- 第7行是一个循环，range(len(seq)-k+1)是用来产生切kmer的位置。
- 第8行中seq[i:i+k]这个就是切得到的kmer，dic[seq[i:i+k]]是存kmer的个数。dic.get(seq[i:i+k],0)是字典中以seq[i:i+k]为key值，的value值，如果字典中没有seq[i:i+k]这个key，dic.get(seq[i:i+k],0)就等于0
- 第9行也是一个循环，相当于perl中的foreach my $key(keys%hash)
- 第10行是打印kmer，和kmer出现的次数







4，将给定的fq文件转成fa格式文件。fq文件路径：

```python
#!/usr/bin/env python
import sys
infile=open(sys.argv[1])
row=1
for i in infile:            #相当于perl中的while(<IN>)，
    i=i.strip()             #想当与perl中的chomp
    if row%4==1:           
        print ">"+i[1:]    #将@换成了>输出
    elif row%4==2:
        print i               #序列那一行，直接输出，不进行过多的操作
    row+=1    
infile.close()
```
思路和perl一样，定义一个row，然后每读一行，row加1，如果row对4求余，如果余数是1，也就是读入的是fq文件中reads的id，将@换成> 。如果余数是2的话，不进行处理。



第二种写法：

```python
#!/usr/bin/env python
import sys
infile=open(sys.argv[1])
line=infile.readline().strip()
row=1
while line:                 #这行和下面那行相当于perl中的while(<IN>)
    if row%4==1:
        print ">"+line[1:]
    elif row%4==2:
        print line
    row+=1
    line=infile.readline().strip()   #这行和上面的while那句相当于while(<IN>)
infile.close() 
```


上面两种写法都可以，区别在于读文件中的内容，第二种写法是以前老写法，第一种是python2.6以后可以那些写的。第一种非常简单明了，非常推荐。







6，统计fa文件中每条contig有多少个碱基数。统计的fa文件就用test4得到的fa结果。

```python
#!/usr/bin/env python
import sys
infile=open(sys.argv[1])
line=infile.readline().strip()
id=line[1:]
print id+"\t",
length=0
for line in infile:
    line=line.strip()
    if line[0]==">":   ##判断是否是id的那一行
        print length   
        id=line[1:]
        print id+"\t",
    else:
        length+=len(line.strip())   ##如果不是reads的id计算长度并统计。
print length
infile.close()
```



