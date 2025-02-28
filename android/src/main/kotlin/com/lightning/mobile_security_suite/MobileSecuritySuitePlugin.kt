package com.lightning.mobile_security_suite

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

const val LOGTAG = "MobileSecuritySuitePlugin"

class MobileSecuritySuitePlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    private lateinit var channel: MethodChannel
    private lateinit var deviceVpnDetector: DeviceVpnDetector
    private lateinit var deviceProxyDetector: DeviceProxyDetector
    private lateinit var deviceWifiSecurityDetector: DeviceWifiSecurityDetector
    private lateinit var deviceScreenMirroringDetector: DeviceScreenMirroringDetector
    private lateinit var deviceLocationMockDetector: DeviceLocationMockDetector
    private lateinit var deviceTapJackingDetector: DeviceTapJackingDetector
    private lateinit var deviceScreenObfuscationDetector: DeviceScreenObfuscationDetector


    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        this.channel = MethodChannel(flutterPluginBinding.binaryMessenger, "mobile_security_suite")

        this.channel.setMethodCallHandler(this)

        this.deviceVpnDetector =
            DeviceVpnDetector().apply { this.onAttachedToPlugin(flutterPluginBinding) }

        this.deviceProxyDetector =
            DeviceProxyDetector().apply { this.onAttachedToPlugin(flutterPluginBinding) }

        this.deviceWifiSecurityDetector =
            DeviceWifiSecurityDetector().apply { this.onAttachedToPlugin(flutterPluginBinding) }

        this.deviceScreenMirroringDetector =
            DeviceScreenMirroringDetector().apply { this.onAttachedToPlugin(flutterPluginBinding) }

        this.deviceLocationMockDetector =
            DeviceLocationMockDetector().apply { this.onAttachedToPlugin(flutterPluginBinding) }
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        this.deviceTapJackingDetector =
            DeviceTapJackingDetector().apply { this.onAttachedToPlugin(binding) }

        this.deviceScreenObfuscationDetector =
            DeviceScreenObfuscationDetector().apply { this.onAttachedToPlugin(binding) }
    }

    override fun onDetachedFromActivityForConfigChanges() {
        this.deviceTapJackingDetector.onDetachedFromPluginForConfigChanges()
        this.deviceScreenObfuscationDetector.onDetachedFromPluginForConfigChanges()
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        this.deviceTapJackingDetector.onReattachedToPluginForConfigChanges(binding)
        this.deviceScreenObfuscationDetector.onReattachedToPluginForConfigChanges(binding)
    }

    override fun onDetachedFromActivity() {
        this.deviceTapJackingDetector.onDetachedFromPlugin()
        this.deviceScreenObfuscationDetector.onDetachedFromPlugin()
    }


    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        this.channel.setMethodCallHandler(null)
        this.deviceVpnDetector.onDetachedFromPlugin(binding)
        this.deviceProxyDetector.onDetachedFromPlugin(binding)
        this.deviceWifiSecurityDetector.onDetachedFromPlugin(binding)
        this.deviceScreenMirroringDetector.onDetachedFromPlugin(binding)
        this.deviceLocationMockDetector.onDetachedFromPlugin(binding)
    }


    override fun onMethodCall(call: MethodCall, result: Result) {
        val arguments: Map<String, Any>? = call.arguments<Map<String, String>>()
        when (call.method) {
            MethodNames.VPN -> this.deviceVpnDetector.performActivity(
                MssArguments(arguments),
                result
            )

            MethodNames.PROXY -> this.deviceProxyDetector.performActivity(
                MssArguments(arguments),
                result
            )

            MethodNames.WIFI_SECURITY -> this.deviceWifiSecurityDetector.performActivity(
                MssArguments(arguments),
                result
            )

            MethodNames.SCREEN_MIRRORING -> this.deviceScreenMirroringDetector.performActivity(
                MssArguments(arguments),
                result
            )

            MethodNames.LOCATION_MOCK -> this.deviceLocationMockDetector.performActivity(
                MssArguments(arguments),
                result
            )

            MethodNames.TAP_JACKING -> this.deviceTapJackingDetector.performActivity(
                MssArguments(arguments),
                result
            )

            MethodNames.SCREEN_OBFUSCATE -> this.deviceScreenObfuscationDetector.performActivity(
                MssArguments(arguments),
                result
            )

            else -> result.notImplemented()
        }
    }

}

interface ActivityDetectable {
    fun performActivity(arguments: MssArguments, result: Result)
}

interface MssPluginBindingInterface : ActivityDetectable {

    fun onAttachedToPlugin(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding)

    fun onDetachedFromPlugin(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding)
}

interface MssActivityBindingInterface : ActivityDetectable {

    fun onAttachedToPlugin(binding: ActivityPluginBinding)

    fun onDetachedFromPluginForConfigChanges()

    fun onReattachedToPluginForConfigChanges(binding: ActivityPluginBinding)

    fun onDetachedFromPlugin()
}

data class MssArguments(val arguments: Map<String, Any>?)

class MethodNames {
    companion object {
        const val VPN = "vpn"
        const val PROXY = "proxy"
        const val WIFI_SECURITY = "wifiSecurity"
        const val SCREEN_MIRRORING = "screenMirroring"
        const val LOCATION_MOCK = "locationMock"
        const val TAP_JACKING = "tapJacking"
        const val SCREEN_OBFUSCATE = "screenObfuscate"
    }
}

