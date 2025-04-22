import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:jailbreak_root_detection/jailbreak_root_detection.dart';

part 'method_channel.dart';

abstract class MobileSecuritySuitePlatform extends PlatformInterface
    implements MobileSecurityInterface {
  MobileSecuritySuitePlatform() : super(token: _token);

  static final Object _token = Object();

  static MobileSecuritySuitePlatform _instance =
      _MethodChannelMobileSecuritySuite();

  static MobileSecuritySuitePlatform get instance => _instance;

  static set instance(MobileSecuritySuitePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }
}

abstract interface class MobileSecurityInterface {
  Future<bool> isDeviceCompromised();

  Future<bool> isRunningOnPhysicalDevice();

  Future<bool> isDeviceDebugging();

  Future<bool> isDeveloperOptionsEnabled();

  Future<bool> isOnExternalStorage();

  Future<bool> isVpnNetworkActive();

  Future<bool> isNetworkProxyEnabled();

  Future<bool> isWifiConnectionSecure();

  Future<bool> isScreenMirroringActive();

  Future<bool> isLocationMocked();

  Future<bool> enableTapJacking();

  Future<bool> disableTapJacking();

  Future<bool> enableScreenObfuscation();

  Future<bool> disableScreenObfuscation();
}
