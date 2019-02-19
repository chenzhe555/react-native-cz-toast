import React, { Component } from 'react';
import { View, Text, StyleSheet, Dimensions } from 'react-native';

export default class ToastView extends Component{
    /************************** 生命周期 **************************/
    constructor(props) {
        super(props);
        this.initializeParams();
    }
    /************************** 继承方法 **************************/
    /************************** 通知 **************************/
    /************************** 创建视图 **************************/
    /************************** 网络请求 **************************/
    /************************** 自定义方法 **************************/
    /*
    * 初始化参数
    * */
    initializeParams() {
        this.state = {
            data: this.props.data ? this.props.data : {}
        };
        this.SCREENH = Dimensions.get('window').height;
        this.SCREENW = Dimensions.get('window').width;
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
        let showType = data['showType'] ? data['showType'] : 3;
        let img = data['img'];

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
                        <View style={[{backgroundColor: 'rgba(58, 58, 58, 0.9)',borderRadius: 5}]}>
                            {
                                img ? (
                                    <View style={[styles.ImageView]}>
                                        {img}
                                    </View>
                                ) : null
                            }
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
        marginTop: 8,
        fontFamily: 'PingFangSC-Regular'
    },

    ImageView: {
        marginTop: 15,
        alignItems: 'center'
    }
})