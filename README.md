
## Manual installation

npm install react-native-cz-toast --save

###依赖库

npm install react-native-cz-pack-element --save

	

## Usage
###  1.引入组件
```
import Toast from 'react-native-cz-toast';
```
###  2.属性:
###  3.属性方法:
###  4.供外部调用的方法:
```
/*
* 显示Toast  (PS：暂时支持的是多次调用的话会依次显示,不会马上停止上次的)
* text: 显示的文本信息
* extraData: 额外参数:{
*   type: 显示类型：目前默认只有1，可不填
*   showType: 显示位置类型：1.底部 2.中间 3.顶部。默认是2
*   during: 显示间隔时间(秒,默认1.5秒)
*   textStyle: 文本视图样式：默认：{marginLeft: 16, marginRight: 16, marginBottom: 15, marginTop: 15}
* }
* */
Toast.show(text = '', extraData = {}, img = null);
```

  
