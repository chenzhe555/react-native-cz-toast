
## Manual installation

npm install react-native-cz-toast --save

	

## Usage
###  1.引入组件
```
import RNCZLoading from 'react-native-cz-loading';

<Toast evaluateView={ (toast) => {this.toast = toast}}></Toast>
```

###  2.方法说明:
```
/*
* 显示Toast
* text: 显示的文本信息
* extraData: 额外参数:{
*   type: 显示类型
*   during: 显示间隔时间(秒,默认1.5秒)
* }
* */
this.loading.show(text = '测试信息'， extraData = {});
```

  
