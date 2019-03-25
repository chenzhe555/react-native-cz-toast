package com.chenzhe.toast;

import android.content.Context;
import android.os.Handler;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.TextView;
import android.widget.Toast;


/**
 * Toast组件
 *
 * @version V1.0
 * @date 2019.3.4 17:15:20
 */
class Toasts {

    /**
     * 显示Toast
     *
     * @param
     * @return
     */
    public void show(Context context, String content) {
        show(context, content, 1, 1.5f);
    }

    /**
     * 显示底部Toast
     *
     * @param
     * @return
     */
    public void show(Context context, String content, float seconds) {
        show(context, content, 1, seconds);
    }


    /**
     * 显示Toast Toast 会依次显示
     *
     * @param context  上下文
     * @param content  内容
     * @param position 位置 -1 0 1 上 中 下
     * @param seconds  秒数 最大 3 秒
     */
    public void show(final Context context, final String content, final int position, final float seconds) {
        final Toast toast = new Toast(context.getApplicationContext());
        configToast(toast, context, content, position);
        toast.show();
        new Handler().postDelayed(new Runnable() {
            @Override
            public void run() {
                toast.cancel();
            }
        }, cancelDelay((seconds)));
    }


    /**
     * 获取取消Toast毫秒值
     *
     * @param seconds 显示Toast的秒数
     * @return long
     */
    private long cancelDelay(float seconds) {
        return ((long) (seconds * 1000));
    }

    /**
     * 配置Toast
     *
     * @param toast    Toast
     * @param context  上下文
     * @param content  内容
     * @param position 位置
     * @return
     */
    private void configToast(Toast toast, Context context, String content, int position) {
        int offSet = dp2px(context, 60);
        toast.setDuration(Toast.LENGTH_LONG);
        switch (position) {
            case 1001:
                toast.setGravity(Gravity.BOTTOM, 0, offSet);
                break;
            case 1002:
                toast.setGravity(Gravity.CENTER, 0, 0);
                break;
            default:
                toast.setGravity(Gravity.CENTER, 0, 0);
                break;
        }
        LayoutInflater inflate = (LayoutInflater)
                context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        View v = inflate.inflate(R.layout.layout_toast, null);
        TextView tv = v.findViewById(R.id.toast_text);
        tv.setText(content);
        toast.setView(v);
    }

    private int dp2px(Context context, int dp) {
        float density = context.getResources().getDisplayMetrics().density;
        return (int) (dp * density + 0.5f);
    }
}
