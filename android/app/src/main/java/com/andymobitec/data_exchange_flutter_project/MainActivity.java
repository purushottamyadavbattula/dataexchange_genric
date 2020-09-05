package com.andymobitec.data_exchange_flutter_project;

import android.os.Bundle;
import android.os.PersistableBundle;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import io.flutter.Log;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "AndySample/test";

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        MethodChannel mc=new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(),CHANNEL);
        mc.setMethodCallHandler((methodCall, result) ->
                {
                    if(methodCall.method.equals("test"))
                    {
                        result.success("Hai from android "+ methodCall.argument("data"));
//Accessing data sent from flutter
                    }
                    else
                    {
                        Log.i("new method came",methodCall.method);
                    }

                }
        );
    }

}
