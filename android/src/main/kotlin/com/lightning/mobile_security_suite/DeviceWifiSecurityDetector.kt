package com.lightning.mobile_security_suite

import android.content.Context
import android.net.ConnectivityManager
import android.net.Network
import android.net.NetworkCapabilities
import android.net.NetworkRequest
import android.net.wifi.WifiInfo
import android.os.Build
import android.util.Log
import androidx.annotation.RequiresApi
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodChannel

class DeviceWifiSecurityDetector : MssPluginBindingInterface {
    private var flutterPluginBinding: FlutterPlugin.FlutterPluginBinding? = null

    override fun onAttachedToPlugin(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        this.flutterPluginBinding = flutterPluginBinding
    }

    override fun performActivity(arguments: MssArguments, result: MethodChannel.Result) {
        try {
            val wifiConnected = isWifiConnected()
            if (wifiConnected && Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
                validateWifiSecurity(result)
            } else {
                result.success(true)
            }
        } catch (exception: Exception) {
            Log.e(LOGTAG, "Exception occurred while performing 'detectWifiSecurityActivity'", exception)
            result.error("1", "Exception occurred while performing 'detectWifiSecurityActivity'", exception)
        }
    }

    private fun isWifiConnected(): Boolean {
        try {
            val applicationContext = this.flutterPluginBinding!!.applicationContext
            val connectivityManager =
                applicationContext.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
            val activeNetwork = connectivityManager.activeNetwork

            if (activeNetwork != null) {
                val networkCapabilities = connectivityManager.getNetworkCapabilities(activeNetwork)
                return networkCapabilities != null && networkCapabilities.hasTransport(
                    NetworkCapabilities.TRANSPORT_WIFI
                )
            }

            return false
        } catch (exception: Exception) {
            Log.e(LOGTAG, "Exception occurred while performing 'isWifiConnected'", exception)
            throw exception
        }
    }

    @RequiresApi(Build.VERSION_CODES.S)
    private fun validateWifiSecurity(result: MethodChannel.Result) {
        try {
            val applicationContext = this.flutterPluginBinding!!.applicationContext
            val networkRequest =
                NetworkRequest.Builder().addTransportType(NetworkCapabilities.TRANSPORT_WIFI)
                    .build()

            val connectionManager =
                applicationContext.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager

            connectionManager.registerNetworkCallback(
                networkRequest,
                object : ConnectivityManager.NetworkCallback(FLAG_INCLUDE_LOCATION_INFO) {
                    override fun onCapabilitiesChanged(
                        network: Network,
                        networkCapabilities: NetworkCapabilities
                    ) {
                        super.onCapabilitiesChanged(network, networkCapabilities)
                        val wifiInfo = networkCapabilities.transportInfo as WifiInfo
                        val securityType = wifiInfo.currentSecurityType
                        result.success(isNetworkTypeSecure(securityType))
                        connectionManager.unregisterNetworkCallback(this)
                    }
                }
            )
        } catch (exception: Exception) {
            Log.e(
                LOGTAG,
                "Exception occurred while performing 'detectWifiSecurityActivity'",
                exception
            )
            result.error(
                "1",
                "Exception occurred while performing 'detectWifiSecurityActivity'",
                exception
            )
        }
    }

    private fun isNetworkTypeSecure(securityType: Int): Boolean {
        return when (securityType) {
            WifiInfo.SECURITY_TYPE_EAP,
            WifiInfo.SECURITY_TYPE_EAP_WPA3_ENTERPRISE,
            WifiInfo.SECURITY_TYPE_EAP_WPA3_ENTERPRISE_192_BIT,
            WifiInfo.SECURITY_TYPE_OWE,
            WifiInfo.SECURITY_TYPE_PASSPOINT_R1_R2,
            WifiInfo.SECURITY_TYPE_PASSPOINT_R3,
            WifiInfo.SECURITY_TYPE_PSK,
            WifiInfo.SECURITY_TYPE_SAE,
            WifiInfo.SECURITY_TYPE_WAPI_CERT,
            WifiInfo.SECURITY_TYPE_WAPI_PSK,
            WifiInfo.SECURITY_TYPE_DPP -> true

            WifiInfo.SECURITY_TYPE_OPEN,
            WifiInfo.SECURITY_TYPE_WEP,
            WifiInfo.SECURITY_TYPE_OSEN,
            WifiInfo.SECURITY_TYPE_UNKNOWN -> false

            else -> false
        }
    }

    override fun onDetachedFromPlugin(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        this.flutterPluginBinding = null
    }
}