下划线`_`,存储我们不会用到或不关心的变量

https://towardsdatascience.com/5-different-meanings-of-underscore-in-python-3fafa6cd0379

```python
# Example 1
for _ in range(10):
  print("I don't care about index")

# Example 2
year, month, day, _,  _, _ = (2020, 7, 10, 12, 10, 59) # year=2020, month=7, day=10
print(_) # 59

# Example 3
year, *_, second = (2020, 7, 10, 12, 10, 59) # year=2020 
print(_) # [7, 10, 12, 10]

# Example 4
monkeypatch.setattr('random.randint', lambda _: 0)
```

