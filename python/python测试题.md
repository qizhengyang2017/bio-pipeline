华农python课的题目

## 出现最多次的整数

输入一组无序的整数，编程输出其中出现次数最多的整数及其出现次数。


```python
a = input().split()

a = [int(i) for i in a] # 列表推导式创建列表

mydict = {}

for i in a:
    mydict[i] = mydict.get(i,0)+1 # get方法获得键相关联的值。第一个参数用于指定键，第二个参数为指定键不存在是返回的值

max_times = max(mydict.values()) # 最大值
data = list(mydict.items()) # 返回键值对列表。
# data.sort() # sort永久性修改列表的排列顺序

for i in data:
    if i[1] == max_times:
        print(i[0],i[1])

```

     3 3 1 2 6


    3 2


## 征友

土生土长的北京妞儿，在胡同里长大房不多，就一个四合院和近郊的别墅。不算美如天仙但还算标致，在清华读的经管，现在在做基金经理，个人擅长基本面分析，价值投资。现在只想找个聪明靠谱的IT男。硬性要求是出生年龄不要超过1990年，我对智商的要求比较高，下面就出个题测试下。我的微信ID是大写字母JH后面跟着两个质数，大的在前，小的在后，乘积是707829217，可直接搜索加微信，请输出该微信号！




```python
def sushu(n):
    # 判断一个数是不是素数，除了1和它自身没有其他约数
    for i in range(2,n): # 生成2到(n-1)的一系列数
        if n%i==0: # %操作符返回余数
            return False
    return True
a = int(input()) # 通过int获取数值输入
result = 'JH'
for i in range(2,a):
    if sushu(i) and a%i==0: # i是素数，同时又是a的约数
        if sushu(a//i): # //floor division，结果是整数（忽略小数）。作用：判断另一个数也得是素数
            result += (str(a//i)+str(i))
            print(result)
            break
else: # for...else construct
    print('该数已经是素数！或者不存在两个同时为素数的约数！')
```

     707829217


    JH866278171


## 循环和函数_亲密数

求整数n以内（含n）的全部亲密数。

说明：如果正整数A的全部因子(包括1，不包括A本身)之和等于B；且正整数B的全部因子(包括1，不包括B本身)之和等于A，A不等于B，则将正整数A和B称为亲密数。
1不和其他数形成亲密数。



```python
# 因子之和
def sumyinzi(n):
    ls = [1,]
    for i in range(2,n):
        if n%i==0:
            ls.append(i)
    return sum(ls)

def sumElem(n):
    mydict = {}
    # 求所有数的因子之和
    for i in range(2,n+1):
        mydict[i] = sumyinzi(i)
    result = []
    
    for i in mydict:
        # mydict[i] in mydict 等价于 mydict[i] in mydict.keys。
        if mydict[i] in mydict and i==mydict[mydict[i]] and i!=mydict[i]:
            result.append((min(i,mydict[i]),max(i,mydict[i]))) # append 添加元组
    result1 = list(set(result)) # 通过集合去重，然后使用list转换成列表
    result1.sort()
    [print(i,j) for i,j in result1]
a = int(input())
sumElem(a)

```

     1000


    220 284


## 位置码加密
导入随机数库产生随机数时设置固定seed(10)。
为给定的字符串原码用随机产生位置码的方式进行加密。例如原码：010512，则位置码为由1-6这6个数字随机产生的数字序列：362415，位置码的生成取决于原码的长度L，每一位都不重复。根据位置码调整原码的顺序得到加密结果：021501，将原码的第3位0放到加密后的第1位，将原码的第6位2放到加密后的第2位，以此类推。
提示注意：对于样例打乱原码位置码123456时如果使用random库中的sample，choice等方法时需要用reverse方法对列表逆序才能和结果一致，用shuffle就不用逆序。

输入一个长度小于10的字符串，根据原码字符串s编写函数posCode(s)产生对应长度的位置码，并作为返回值返回。

根据原码字符串s和位置码posCode编写函数changeCode(s,posCode)实现原码根据位置码转换成加密后的字符串，并作为返回值返回



```python
import random
random.seed(10)

# 获得位置码，010512 -> [3, 1, 6, 5, 4, 2]
def posCode(str_len):
    index_ls = [i for i in range(1, str_len + 1)] # 1,2,3..n的一列数
    random.shuffle(index_ls) # index_ls被随机打乱
    return index_ls

# 源码根据位置码转换
def changeCode(s,poscode):
    poscode = [i-1 for i in poscode]
    result = ''
    for i in poscode:
        result+=s[i]
    return result

s = input()
poscode = posCode(len(s))
pos = ''
for i in poscode:
    pos+=str(i)
print(pos)
result = changeCode(s,poscode)
print(result)

```

     010512


    362415
    021501


## 通过年份和月份，求该月天数
输入日期的年份和月份，求该月有多少天。提示：对于月份为1、3、5、7、8、10、12的月份天数为31，月份为4、6、9、11的月份天数为30，月份为2时要结合年份考虑闰年的情况。


```python
(x,y)=eval(input("year,month:")) # eval将输入转成元组
if y in [1,3,5,7,8,10,12]:
    print("31")
elif y in [4,6,9,11]:
    print("30")
else:
    if x%4==0 and x%100!=0 or x%400==0:
        print("29")
    else:
        print("28")

```

    year,month: 2021,2


    28


## 矩阵的乘法
编写程序，完成2x3矩阵和3x2整数矩阵的乘法，输出结果矩阵。


```python
data = input()
data = [int(i) for i in data.split()]
# 定义两个矩阵，只不过是单行的，为了方便做乘法
x=2
y=3
z=x*y

a = data[:z]
b = data[z:]
# 最后的结果矩阵
c = []
# 两个矩阵相乘
for i in range(x):
    ls = []
    for j in range(x):
        a_temp = a[i*y:(i+1)*y] # a矩阵第i行的数
        b_temp = b[j::x] # b矩阵第j列
        # 行列相乘
        result = 0
        for num_a,num_b in zip(a_temp,b_temp): # zip将对应的元素打包成一个元组
            result += num_a*num_b
        ls.append(result)
    c.append(ls)
#-------------------------   打印出相乘|后的矩阵  --------------------   
for i in range(len(c)):
    # 输出一行信息
    for j in range(x):
        print('%8s'%c[i][j],end='') #格式化输出
    print() # produce an invisible newline character

```

      1 2 3 0 1 0 1 2 5 6 2 3


          17      23
           5       6


## 求多项式的和
编写一个函数mySum(a,n)，求以下n项式的和：
s=a+aa+aaa+…+aa…a， 其中a是1~9的数字，最后一项是n位都是a的数字


```python
def mySum(a,n):
    # lambda n:sum(list(map(lambda n:a*(10**n),range(n))))
    # map(lambda n:a*(10**n),range(n))
    list1=list(map(lambda n:sum(list(map(lambda n:a*(10**n),range(n)))),range(1,n+1))) # lambda n:a*(10**n)匿名函数，map作用于列表中的每个元素。这里写的很复杂。目的是得到一串序列，a+aa+aaa+…+aa…a
    return sum(list1) # 列表中的元素求和
x,y=eval(input())
mySum(x,y)
print(mySum(x,y))

```

     2,3


    246



## 停车费
进入停车场开始计费。停车时间小于0.5小时不收费；每小时收费5元；不足1小时按1小时收费；最多收费50元也就是10小时以上都是50元。


```python
import math
hours=eval(input("time:"))
if(hours<0.5):
    cost=0
elif(0.5<hours<10):
        cost=math.ceil(hours)*5 # Round a number upward to its nearest integer
elif(50<=hours):
        cost=50
print(cost)

```

    time: 2


    10


## 字符串中字母大小写互换


```python
a=input()
sum=''
for m in a:
    if 'A'<=m<='Z':
        sum=sum+chr(ord(m)+32) # ord返回字符的 ASCII 数值；chr返回数值对应的字符
    elif 'a'<=m<='z':
        sum=sum+chr(ord(m)-32)
    else:
        sum=sum+m
print(sum)
```

     Bz


    bZ


## 随机密码
请编写程序，生成随机密码。具体要求如下：‪‪‪‪‪‫‪‪‪‪‪‪‫‪‪‪‪‪‪‪‪‪‪‪‫‪‪‪‪‪‪‪‪
（1）使用 random 库，采用 10作为随机数种子。‪‪‪‪‪‫‪‪‪‪‪‪‫‪‪‪‪‪‪‪‪‪‪‪‫‪‪‪‪‪‪‪‪

提示：random.seed(10)，不能用sample函数这是不放回抽样。
（2）密码允许字符如下：

“abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890”
（3）密码长度为输入的数字。


```python
import random
random.seed(10)
s = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890'
length = eval(input())
ans = ''
for i in range(length):
    ans+=random.choice(s)
print(ans)
```

     4


    KcBE


## 找因子
输入一个大于1的整数，返回一个列表，包含所有能够整除该整数的因子（不包含1和它本身），并且从小到大排序。如果这个数是素数，则输出“(整数) is prime”。


```python
a=eval(input('number:'))
list1=[]
for i in range(2,a//2+1): # 因子不会超过a//2+1
    if a%i==0:
        list1.append(int(i))
        list1.append(int(a/i))
list1=list(set(list1))
if len(list1)==0:
    print('%s is prime'%a)
else:
    print(list1)

```

    number: 42


    [2, 3, 6, 7, 14, 21]


## 统计高于平均分的人数
从若干学生成绩中统计高于(严格的大于)平均分的人数，用-1做为学生成绩数据的结束标志


```python
line = input()
nums = [eval(x) for x in line.split()[:-1]] # 列表推到式[expr for val in collection if condition]

sum(nums)/len(nums)

aver_score = sum(nums)/len(nums)

r=[x for x in nums if x>aver_score]

print(len(r))
```

     1 2 3 -1


    1


## 根据用户输入的日期计算是一年中的第几天
编写函数isLeap(year)用于判断year是否是闰年，若是闰年则返回True，否则返回False。


```python
def isLeap(year):
    if year%4==0 and year%100!=0 or year%400==0:
        return True
    else:
        return False
def days(year,month):
    dict1={1:31,3:31,5:31,7:31,8:31,10:31,12:31,4:30,6:30,9:30,11:30}
    sum1=0
    if isLeap(year):
        dict1[2]=29
    else:
        dict1[2]=28
    for i in dict1:
        if i<month:
            sum1=sum1+dict1[i]
    print(sum1+list1[2])
a=input()
list1=a.split('/')
list1=[int(i) for i in list1]
year=list1[0]
month=list1[1]
day=list1[2]
days(year,month)

```

     2021/12/28


    362


## 统计一共出现了多少个3
输入任意一个正整数，从1开始到这个数字的奇数序列里，统计一共出现了多少个3。
编写函数sumThree()，实现功能是，输入一个正整数，返回该数中3出现的个数。


```python
def sumThree(n):
    sum=0
    for i in range(1,int(n)+1):
        if i%2!=0: # 不能被2整除
            sum+=str(i).count("3")
    return sum
x=input("number:")
print(sumThree(x))

```

    number: 32


    4


## 输出斐波拉契数列-上机考试题
定义一个函数fib，给定n，返回n以内的斐波那契数列。
注：斐波拉契数列由0和1开始，之后的数就是由之前的两数相加而得出：0, 1, 1, 2, 3, 5, 8, 13, 21



```python
num=eval(input('input a number please:'))
list1=[0,1]
c=1
i=1
while 1: # 等于 while True:
    c=list1[i]+list1[i-1]
    if c>num:
        break # 退出循环
    else:
        i+=1
        list1.append(c)
for i in list1[1:]:
    print(i,end=',')
```

    input a number please: 5


    1,1,2,3,5,
