# 瀑布流首页

参考[nodebb-plugin-custom-homepage](https://github.com/NodeBB/nodebb-plugin-custom-homepage)实现的瀑布流首页。

主要做了

- 增加自定义首页
- 增加最新帖子 widget

## 使用

```bash
npm i --save nodebb-plugin-masonry-index
```

在“拓展“ -> ”插件“ 找到并启用，会提示重启`NodeBB`，重启完成后，到”拓展“ -> ”窗口部件“ 中，选中`homepage.tpl`，这是新增的一个页面。然后右侧”可用的窗口部件“下拉项，找到`Masonry Posts`，拖到左侧的`Custom HP Content`内，保存。

> 由于在手机端不怎么好看，可以点击该`widget`，勾选`Hide on mobile?`并保存。

再到”基本“ -> ”主页“，将”主页路由“配置项修改为`Masonry Homepage`，保存。

进入首页，刷新即可。