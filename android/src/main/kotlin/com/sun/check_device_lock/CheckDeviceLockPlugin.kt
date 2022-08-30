package com.sun.check_device_lock

import android.app.Activity
import android.app.KeyguardManager
import android.content.Context
import android.os.Build
import androidx.annotation.NonNull
import androidx.annotation.RequiresApi
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** CheckDeviceLockPlugin */
class CheckDeviceLockPlugin : FlutterPlugin, MethodCallHandler, Activity() {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private lateinit var context: Context
    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "sun_check_device_lock")
        context = flutterPluginBinding.applicationContext
        channel.setMethodCallHandler(this)
    }

    @RequiresApi(Build.VERSION_CODES.LOLLIPOP_MR1)
    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        if (call.method == "isDeviceSecure") {
            val isDeviceSecure = isDeviceSecure()
            result.success(isDeviceSecure)
        } else {
            result.notImplemented()
            result.success(false)
        }
    }

    /// Method use to get true and false value
    /// If device has password or any biometric authentication then it return true otherwise return false.
    @RequiresApi(Build.VERSION_CODES.LOLLIPOP_MR1)
    private fun isDeviceSecure(): Boolean {
        val myKM = context.getSystemService(KEYGUARD_SERVICE) as KeyguardManager
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            myKM.isDeviceSecure
        } else {
            true
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
