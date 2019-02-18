
## Manual installation

npm install react-native-cz-toast --save

	

## Usage
###  1.引入组件
```
import Toast from 'react-native-cz-toast';

<Toast evaluateView={ (toast) => {this.toast = toast}}></Toast>
```

###  2.方法说明:
/*
* 赋值当前视图对象
* */
evaluateView

```
/*
* 显示Toast
* text: 显示的文本信息
* extraData: 额外参数:{
*   type: 显示类型：目前默认只有1，可不填
*   showType: 显示位置类型：1.底部 2.中间 3.顶部。默认是2
*   during: 显示间隔时间(秒,默认1.5秒)
*   textStyle: 文本视图样式：默认：{marginLeft: 16, marginRight: 16, marginBottom: 15, marginTop: 15}
* }
* */
this.loading.show(text = '测试信息'， extraData = {});
```

  
