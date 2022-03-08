### svg生成图例

我不知道怎么搞。但是我有颜色值。怎么生成热图的图例呢？
svg画热图图例

可以自己画
```xml
<svg width='120' height='40'>
<rect x='10' y='5' width='30' height='30' style='fill:#7a65d4'/>
<rect x='40' y='5' width='30' height='30' style='fill:#e74815'/>
<rect x='70' y='5' width='30' height='30' style='fill:#1c7bf3'/>
</svg>
```
如果用rgb，`<rect width="300" height="100" style="fill:rgb(0,0,255);stroke-width:3;stroke:rgb(0,0,0)" />`

参考(https://mp.weixin.qq.com/s/4G0R1tSK6UvxowM6YTxorw)

circos颜色(http://www.circos.ca/documentation/tutorials/2d_tracks/heat_maps/)
