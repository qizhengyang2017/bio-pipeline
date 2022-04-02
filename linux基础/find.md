## find

```sh
find . -name "independent*"
```



```sh
# mac上搜索，排除Library目录
find . -path ./Library -prune -o  -name "*ipynb"


# 搜索jupyter notebook
# 括号里的-o代表或v
find ~ \( -path ~/Library -o -path ~/opt \) -prune -o -type f -name "*ipynb"|grep -v ".ipynb_checkpoints"

find ~ \( -path ~/Library -o -path ~/opt \) -prune -o -type f -name "test.txt"
```

移动目录

```sh
find . -maxdepth 1 -type f -mmin -180 -exec mv {} cis_trans \;

# 删除七天前的数据
find . -maxdepth 1 -type f -mtime +7 -name "*out" -delete 
```



```bash
find ~ -type f -size +1G  -print0 | xargs -0 du -h | sort -nr
find . -maxdepth 1 -size 1|xargs|rm -rf
```

