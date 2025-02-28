package com.lightning.mobile_security_suite

import android.content.Context
import android.net.ConnectivityManager
import android.net.NetworkCapabilities
import android.util.Log
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodChannel.Result
import java.net.NetworkInterface

class DeviceVpnDetector : MssPluginBindingInterface {
    private var flutterPluginBinding: FlutterPlugin.FlutterPluginBinding? = null

    override fun onAttachedToPlugin(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        this.flutterPluginBinding = flutterPluginBinding
    }

    override fun performActivity(arguments: MssArguments, result: Result) {
        try {
            result.success(this.detectViaNetworkCapabilities() || this.detectViaNetworkInterface())
        } catch (exception: Exception) {
            Log.e(LOGTAG, "Exception occurred while performing 'detectVpnActivity'", exception)
            result.error("1", "Exception occurred while performing 'detectVpnActivity'", exception)
        }
    }

    private fun detectViaNetworkCapabilities(): Boolean {
        try {
            val applicationContext = this.flutterPluginBinding!!.applicationContext
            val connectivityManager =
                applicationContext.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
            val activeNetwork = connectivityManager.activeNetwork

            if (activeNetwork != null) {
                val networkCapabilities = connectivityManager.getNetworkCapabilities(activeNetwork)
                return networkCapabilities != null && networkCapabilities.hasTransport(
                    NetworkCapabilities.TRANSPORT_VPN
                )
            }

            return false
        } catch (exception: Exception) {
            Log.e(
                LOGTAG,
                "Exception occurred while performing 'detectViaNetworkCapabilities'",
                exception
            )
            throw exception
        }
    }

    private fun detectViaNetworkInterface(): Boolean {
        try {
            val networkInterfaces = NetworkInterface.getNetworkInterfaces()
            for (networkInterface in networkInterfaces) {
                if (networkInterface.isUp && (networkInterface.displayName.lowercase()
                        .contains("tun") ||
                            networkInterface.displayName.lowercase().contains("ppp") ||
                            networkInterface.displayName.lowercase().contains("ipsec") ||
                            networkInterface.displayName.lowercase().contains("wg"))
                ) {
                    return true
                }
            }
            return false
        } catch (exception: Exception) {
            Log.e(
                LOGTAG,
                "Exception occurred while performing 'detectViaNetworkInterface'",
                exception
            )
            throw exception
        }
    }

    override fun onDetachedFromPlugin(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        this.flutterPluginBinding = null
    }
}