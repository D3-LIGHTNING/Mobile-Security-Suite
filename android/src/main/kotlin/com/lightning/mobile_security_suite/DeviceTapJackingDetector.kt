package com.lightning.mobile_security_suite

import android.app.Activity
import android.os.Build
import android.util.Log
import android.view.View
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodChannel

class DeviceTapJackingDetector : MssActivityBindingInterface {
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

            val activity: Activity = this.activityPluginBinding!!.activity

            val view: View = activity.findViewById(android.R.id.content)
                ?: activity.window.decorView.findViewById(android.R.id.content)

            view.rootView.filterTouchesWhenObscured = detectionState
            view.filterTouchesWhenObscured = detectionState

            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
                activity.window.setHideOverlayWindows(detectionState)
            }

            result.success(true)
        } catch (exception: Exception) {
            Log.e(
                LOGTAG,
                "Exception occurred while performing 'detectTapJackingActivity'",
                exception
            )
            result.error(
                "1",
                "Exception occurred while performing 'detectTapJackingActivity'",
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