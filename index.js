import React, { Component } from 'react';
import CZPackElement from 'react-native-cz-pack-element';
import Toast from './toast';


/*
* zIndex: 2890
* */
export default class CZToast extends Component {

    //Toast显示方位
    static ShowType = {
        bottom: 1,
        center: 2,
        top: 3
    }
    //显示数据源数组
    static showArr = [];
    //当前是否正在显示Toast
    static isShowToast = false;

    /************************** 生命周期 **************************/
    /************************** 继承方法 **************************/
    /************************** 通知 **************************/
    /************************** 创建视图 **************************/
    /************************** 网络请求 **************************/
    /************************** 自定义方法 **************************/
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
    static show = (text = '', extraData = {}, img = null) => {
        if (text.length <= 0) return;

        //赋值Toast新数组元素
        extraData['text'] = text;
        extraData['during'] = (parseFloat(extraData['during'] ? extraData['during'] : 1.5))*1000;
        extraData['img'] = img;
        this.showArr.push(extraData);
        //显示Toast
        if (!this.isShowToast) this.showToast();
    }

    //显示Toast
    static showToast = () => {
        //当前显示数组第一个Toast对象
        let item = this.showArr[0];
        let element = new CZPackElement(<Toast data={item}/>);
        this.isShowToast = true;
        //during时间后再做逻辑判断
        setTimeout( () => {
            element.destoryElement();
            this.showArr.splice(0,1);
            if (this.showArr.length > 0) {
                this.showToast();
            } else {
                this.isShowToast = false;
            }
        }, item['during']);
    }

    /************************** 子组件回调方法 **************************/
    /************************** 外部调用方法 **************************/
    /************************** List相关方法 **************************/
    /************************** Render中方法 **************************/
}