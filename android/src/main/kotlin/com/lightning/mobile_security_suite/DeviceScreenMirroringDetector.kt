package com.lightning.mobile_security_suite

import android.content.Context
import android.hardware.display.DisplayManager
import android.util.Log
import android.view.Display
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodChannel

class DeviceScreenMirroringDetector : MssPluginBindingInterface {
    private var flutterPluginBinding: FlutterPlugin.FlutterPluginBinding? = null

    override fun onAttachedToPlugin(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        this.flutterPluginBinding = flutterPluginBinding
    }

    override fun performActivity(arguments: MssArguments, result: MethodChannel.Result) {
        try {
            result.success(isScreenMirroring())
        } catch (exception: Exception) {
            Log.e(
                LOGTAG,
                "Exception occurred while performing 'detectScreenMirroringActivity'",
                exception
            )
            result.error(
                "1",
                "Exception occurred while performing 'detectScreenMirroringActivity'",
                exception
            )
        }
    }

    private fun isScreenMirroring(): Boolean {
        try {
            val applicationContext = flutterPluginBinding!!.applicationContext
            val displayManager =
                applicationContext.getSystemService(Context.DISPLAY_SERVICE) as DisplayManager
            val displays = displayManager.displays
            if (displays.size > 1) {
                for (display in displays) {
                    if (display.displayId != Display.DEFAULT_DISPLAY && display.flags and Display.FLAG_PRESENTATION != 0) {
                        return true
                    }

                }
            }
            return false
        } catch (exception: Exception) {
            Log.e(LOGTAG, "Exception occurred while performing 'isScreenMirroring'", exception)
            throw exception
        }
    }

    override fun onDetachedFromPlugin(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        this.flutterPluginBinding = null
    }
}