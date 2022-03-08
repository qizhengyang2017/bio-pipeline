```bash
module load Circos/0.69-8
```



### 如何快速上手circos

注意几个配置文件
先配置象形
~/work/ga/hotspot_all/hotspot_result_new

### 如何使A01和D13左右对齐
染色体间距是0.005r
0.05*360/2=9
-90+9=-81

但是这个间距不对，不知道原因。差不多就行了吧。微调到-82.3，大概距离中心线150像素。

[spacing breaks](http://circos.ca/documentation/tutorials/ideograms/variable_radius/)

Circos doesn't yet draw color legends. You can get a list of the color encoding by using `-debug_group legend`. (http://circos.ca/documentation/tutorials/2d_tracks/heat_maps/)



`circos -conf ... -debug_group legend`



