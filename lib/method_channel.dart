part of 'platform_interface.dart';

class _MethodChannelMobileSecuritySuite extends MobileSecuritySuitePlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('mobile_security_suite');

  @override
  Future<bool> isDeviceCompromised() async =>
      await JailbreakRootDetection.instance.isJailBroken;

  @override
  Future<bool> isRunningOnPhysicalDevice() =>
      JailbreakRootDetection.instance.isRealDevice;

  @override
  Future<bool> isDeviceDebugging() async =>
      await JailbreakRootDetection.instance.isDebugged;

  @override
  Future<bool> isDeveloperOptionsEnabled() async =>
      Platform.isIOS ? false : await JailbreakRootDetection.instance.isDevMode;

  @override
  Future<bool> isOnExternalStorage() async => Platform.isIOS
      ? false
      : await JailbreakRootDetection.instance.isOnExternalStorage;

  @override
  Future<bool> isVpnNetworkActive() async =>
      await methodChannel.invokeMethod<bool>(MethodNames.vpn) ?? false;

  @override
  Future<bool> isNetworkProxyEnabled() async =>
      await methodChannel.invokeMethod<bool>(MethodNames.proxy) ?? false;

  @override
  Future<bool> isWifiConnectionSecure() async =>
      await methodChannel.invokeMethod<bool>(MethodNames.wifiSecurity) ?? false;

  @override
  Future<bool> isScreenMirroringActive() async =>
      await methodChannel.invokeMethod<bool>(MethodNames.screenMirroring) ??
      false;

  @override
  Future<bool> isLocationMocked() async =>
      await methodChannel.invokeMethod<bool>(MethodNames.locationMock) ?? false;

  @override
  Future<bool> enableTapJacking() async =>
      await methodChannel
          .invokeMethod<bool>(MethodNames.tapJacking, {"state": true}) ??
      false;

  @override
  Future<bool> disableTapJacking() async =>
      await methodChannel
          .invokeMethod<bool>(MethodNames.tapJacking, {"state": false}) ??
      false;

  @override
  Future<bool> enableScreenObfuscation() async =>
      await methodChannel
          .invokeMethod<bool>(MethodNames.screenObfuscate, {"state": true}) ??
      false;

  @override
  Future<bool> disableScreenObfuscation() async =>
      await methodChannel
          .invokeMethod<bool>(MethodNames.screenObfuscate, {"state": false}) ??
      false;
}

class MethodNames {
  static const vpn = "vpn";
  static const proxy = "proxy";
  static const wifiSecurity = "wifiSecurity";
  static const screenMirroring = "screenMirroring";
  static const locationMock = "locationMock";
  static const tapJacking = "tapJacking";
  static const screenObfuscate = "screenObfuscate";
}
