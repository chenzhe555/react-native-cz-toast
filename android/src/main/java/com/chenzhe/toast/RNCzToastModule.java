
package com.chenzhe.toast;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.Callback;

public class RNCzToastModule extends ReactContextBaseJavaModule {

    private final ReactApplicationContext reactContext;

    public RNCzToastModule(ReactApplicationContext reactContext) {
        super(reactContext);
        this.reactContext = reactContext;
    }

    @Override
    public String getName() {
        return "RNCzToast";
    }

    @ReactMethod
    public void showToastWithType(int type, String text, float time) {
        if(getCurrentActivity() == null|| getCurrentActivity().isFinishing()) {
            return;
        }
        new Toasts().show(getCurrentActivity(),text,type,time);
    }
}