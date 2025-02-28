package com.lightning.mobile_security_suite

import android.util.Log
import android.view.WindowManager
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodChannel

class DeviceScreenObfuscationDetector : MssActivityBindingInterface {
    private var activityPluginBinding: ActivityPluginBinding? = null

    override fun onAttachedToPlugin(binding: ActivityPluginBinding) {
        this.activityPluginBinding = binding
    }

    override fun onDetachedFromPluginForConfigChanges() {
        this.activityPluginBinding = null
    }

    override fun performActivity(arguments: MssArguments, result: MethodChannel.Result) {
        try {
            val detectionState: Boolean = arguments.arguments!!["state"] as Boolean
            val activity = this.activityPluginBinding!!.activity

            if (detectionState) {
                activity.window.setFlags(
                    WindowManager.LayoutParams.FLAG_SECURE,
                    WindowManager.LayoutParams.FLAG_SECURE
                )
            } else {
                activity.window.clearFlags(WindowManager.LayoutParams.FLAG_SECURE)
            }
            result.success(true)
        } catch (exception: Exception) {
            Log.e(
                LOGTAG,
                "Exception occurred while performing 'detectScreenObfuscationActivity'",
                exception,
            )
            result.error(
                "1",
                "Exception occurred while performing 'detectScreenObfuscationActivity'",
                exception
            )
        }
    }

    override fun onReattachedToPluginForConfigChanges(binding: ActivityPluginBinding) {
        this.activityPluginBinding = binding
    }

    override fun onDetachedFromPlugin() {
        this.activityPluginBinding = null
    }
}