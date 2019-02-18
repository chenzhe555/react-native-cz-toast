import React, { Component } from 'react';
import { View, Text, StyleSheet, Dimensions } from 'react-native';


/*
* zIndex: 2890
* */
export default class CZToast extends Component {

    /************************** 生命周期 **************************/
    constructor(props) {
        super(props);
        //赋值初始值
        this.state = {
            data: {}
        };
        //显示数据源数组
        this.showArr = [];
        //当前是否正在显示Toast
        this.isShowToast = false;
        //屏幕宽高
        this.SCREENH = Dimensions.get('window').height;
        this.SCREENW = Dimensions.get('window').width;
    }

    componentDidMount() {
        if (this.props.evaluateView) this.props.evaluateView(this);
    }
    /************************** 继承方法 **************************/
    /************************** 通知 **************************/
    /************************** 创建视图 **************************/
    /************************** 网络请求 **************************/
    /************************** 自定义方法 **************************/
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
    show(text = '', extraData = {}) {
        if (text.length <= 0) return;

        //赋值Toast新数组元素
        extraData['text'] = text;
        extraData['during'] = (parseFloat(extraData['during'] ? extraData['during'] : 1.5))*1000;
        this.showArr.push(extraData);
        //显示Toast
        if (!this.isShowToast) this.showToast();
    }

    //显示Toast
    showToast() {
        //当前显示数组第一个Toast对象
        let item = this.showArr[0];
        this.setState({
            data: item
        });
        this.isShowToast = true;

        //during时间后再做逻辑判断
        setTimeout( () => {
            this.showArr.splice(0,1);
            if (this.showArr.length > 0) {
                this.showToast();
                this.isShowToast = true;
            } else {
                this.isShowToast = false;
                this.setState({
                    data: {}
                });
            }
        },item['during']);
    }

    /************************** 子组件回调方法 **************************/
    /************************** 外部调用方法 **************************/
    /************************** List相关方法 **************************/
    /************************** Render中方法 **************************/
    render() {
        const { data } = this.state;
        const { SCREENW } = this;
        //文本信息
        let text = data['text'] ? data['text'] : '';
        if (text.length == 0) return null;
        //显示类型
        let type = data['type'] ? data['type'] : 1;
        //Toast相对位置
        let showType = data['showType'] ? data['showType'] : 2;

        //Text相对坐标
        let mLeft = data['marginLeft'] ? data['marginLeft'] : 16;
        let mRight = data['marginRight'] ? data['marginRight'] : 16;
        let mBottom = data['marginBottom'] ? data['marginBottom'] : 15;
        let mTop = data['marginTop'] ? data['marginTop'] : 15;

        if (type == 1) {
            //总视图样式
            let stylesArr = [];
            stylesArr.push(styles.MainView);
            if (showType == 1) {
                stylesArr.push({
                    bottom: 30
                });
            } else if (showType == 2) {
                stylesArr.push({
                    top: (this.SCREENH/2 - 30)
                });
            } else {
                stylesArr.push({
                    top: 60
                });
            }

            //文本样式
            let textStyles = [];
            textStyles.push(styles.TextView);
            if (data['textStyle']) textStyles.push(data['textStyle']);

            return (
                <View style={[stylesArr]}>
                    <View style={[styles.ContentView, {width: (SCREENW - 48)}]}>
                        <View style={[{backgroundColor: 'rgba(0,0,0,0.3)',borderRadius: 4}]}>
                            <Text style={textStyles}>{text}</Text>
                        </View>
                    </View>
                </View>
            );
        } else {
            return null;
        }
    }
}

const styles = StyleSheet.create({
    MainView: {
        position: 'absolute',
        zIndex: 2890
    },

    ContentView: {
        justifyContent: 'center',
        alignItems: 'center',
        marginLeft: 24,
        marginRight: 24
    },

    TextView: {
        fontSize: 14,
        color: 'white',
        marginLeft: 15,
        marginRight: 15,
        marginBottom: 10,
        marginTop: 10
    }
})

CZToast.ShowType = {
    bottom: 1,
    center: 2,
    top: 3
}