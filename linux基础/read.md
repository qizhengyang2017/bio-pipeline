## bash的循环操作
```sh
# read -a: Each name is an indexed array variable (see Arrays above).
cat QTL_select_14.txt|while read -a NAME
do
echo ${NAME[2]}
done
```
