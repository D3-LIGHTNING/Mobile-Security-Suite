package com.lightning.mobile_security_suite

import android.content.Context
import android.net.ConnectivityManager
import android.util.Log
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodChannel

class DeviceProxyDetector : MssPluginBindingInterface {
    private var flutterPluginBinding: FlutterPlugin.FlutterPluginBinding? = null

    override fun onAttachedToPlugin(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        this.flutterPluginBinding = flutterPluginBinding
    }

    override fun performActivity(arguments: MssArguments, result: MethodChannel.Result) {
        try {
            result.success(this.isUsingProxy() || this.isProxyEnabled())
        } catch (exception: Exception) {
            Log.e(LOGTAG, "Exception occurred while performing 'detectProxyActivity'", exception)
            result.error(
                "1",
                "Exception occurred while performing 'detectProxyActivity'",
                exception
            )
        }
    }

    private fun isProxyEnabled(): Boolean {
        try {
            val proxyHost = System.getProperty("http.proxyHost")
            val proxyPort = System.getProperty("http.proxyPort")?.toIntOrNull() ?: 0
            val httpsProxyHost = System.getProperty("https.proxyHost")
            val httpsProxyPort = System.getProperty("https.proxyPort")?.toIntOrNull() ?: 0

            return (!proxyHost.isNullOrEmpty() && proxyPort > 0) || (!httpsProxyHost.isNullOrEmpty() && httpsProxyPort > 0)

        } catch (exception: Exception) {
            Log.e(LOGTAG, "Exception occurred while performing 'isProxyEnabled'", exception)
            throw exception
        }
    }

    private fun isUsingProxy(): Boolean {
        try {
            val applicationContext = this.flutterPluginBinding!!.applicationContext
            val connectivityManager =
                applicationContext.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
            val activeNetwork = connectivityManager.activeNetwork
            if (activeNetwork != null) {
                val linkProperties = connectivityManager.getLinkProperties(activeNetwork)
                if (linkProperties != null) {
                    val proxyInfo = linkProperties.httpProxy
                    return proxyInfo != null
                }

            }
            return false
        } catch (exception: Exception) {
            Log.e(LOGTAG, "Exception occurred while performing 'isUsingProxy'", exception)
            throw exception
        }
    }

    override fun onDetachedFromPlugin(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        this.flutterPluginBinding = null
    }
}