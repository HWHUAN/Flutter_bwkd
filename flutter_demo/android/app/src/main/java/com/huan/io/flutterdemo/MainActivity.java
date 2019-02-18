package com.huan.io.flutterdemo;

import android.os.Build;
import android.os.Bundle;
import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    //fultter 默认的状态栏是半透明的，所以要判断5.0以上后要设置成透明才能让标题栏颜色和状态栏颜色一致
    if(Build.VERSION.SDK_INT>=Build.VERSION_CODES.LOLLIPOP)
    {//API>21,设置状态栏颜色透明
      getWindow().setStatusBarColor(0);
    }
    GeneratedPluginRegistrant.registerWith(this);
  }
}
