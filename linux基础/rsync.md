rsync传数据

```sh
rsync -e 'ssh -p 22333'  -avp hotspot_result_new lab:~/ga/hotspot/hot_scan_newCis
```

