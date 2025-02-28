package com.lightning.mobile_security_suite

import android.content.Context
import android.location.LocationManager
import android.os.Build
import android.util.Log
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodChannel

class DeviceLocationMockDetector : MssPluginBindingInterface {
    private var flutterPluginBinding: FlutterPlugin.FlutterPluginBinding? = null

    override fun onAttachedToPlugin(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        this.flutterPluginBinding = flutterPluginBinding
    }

    override fun performActivity(arguments: MssArguments, result: MethodChannel.Result) {
        try {
            result.success(this.detectLocationMock())
        } catch (exception: SecurityException) {
            Log.e(
                LOGTAG,
                "SecurityException occurred while performing 'detectLocationMockActivity'",
                exception
            )
            result.error(
                "2",
                "SecurityException occurred while performing 'detectLocationMockActivity'",
                exception
            )
        } catch (exception: Exception) {
            Log.e(
                LOGTAG,
                "Exception occurred while performing 'detectLocationMockActivity'",
                exception
            )
            result.error(
                "1",
                "Exception occurred while performing 'detectLocationMockActivity'",
                exception
            )
        }
    }

    private fun detectLocationMock(): Boolean {
        try {
            val applicationContext = this.flutterPluginBinding!!.applicationContext

            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
                val locationManager =
                    applicationContext.getSystemService(Context.LOCATION_SERVICE) as LocationManager
                val allProviders = locationManager.allProviders

                for (provider in allProviders) {
                    if (LocationManager.GPS_PROVIDER == provider || LocationManager.NETWORK_PROVIDER == provider) {
                        if (locationManager.isProviderEnabled(provider)) {
                            val location = locationManager.getLastKnownLocation(provider)
                            if (location != null && location.isMock) {
                                return true
                            }
                        }
                    }
                }
            }

            return false
        } catch (exception: SecurityException) {
            Log.e(
                LOGTAG,
                "SecurityException occurred while performing 'detectLocationMockActivity'",
                exception
            )
            throw exception
        } catch (exception: Exception) {
            Log.e(
                LOGTAG,
                "Exception occurred while performing 'detectLocationMockActivity'",
                exception
            )
            throw exception

        }
    }

    override fun onDetachedFromPlugin(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        this.flutterPluginBinding = null
    }
}