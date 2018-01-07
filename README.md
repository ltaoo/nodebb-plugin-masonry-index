# 瀑布流首页

参考[nodebb-plugin-custom-homepage](https://github.com/NodeBB/nodebb-plugin-custom-homepage)实现的瀑布流首页。

主要做了

- 增加自定义首页
- 增加最新帖子 widget

## 使用

```bash
npm i --save nodebb-plugin-masonry-index
```

参考`custom-homepage`增加首页后，在配置`widget`的时候，把`Masonry Index`这个组件放到`content`容器即可（大概）。