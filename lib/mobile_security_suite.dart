import 'platform_interface.dart';

class MobileSecuritySuite implements MobileSecuritySuitePlatform {
  const MobileSecuritySuite._internal();
  static MobileSecuritySuite? _instance;

  @override
  Future<bool> isDeviceCompromised() =>
      MobileSecuritySuitePlatform.instance.isDeviceCompromised();

  @override
  Future<bool> isRunningOnPhysicalDevice() =>
      MobileSecuritySuitePlatform.instance.isRunningOnPhysicalDevice();

  @override
  Future<bool> isDeviceDebugging() =>
      MobileSecuritySuitePlatform.instance.isDeviceDebugging();

  @override
  Future<bool> isDeveloperOptionsEnabled() =>
      MobileSecuritySuitePlatform.instance.isDeveloperOptionsEnabled();

  @override
  Future<bool> isOnExternalStorage() =>
      MobileSecuritySuitePlatform.instance.isOnExternalStorage();

  @override
  Future<bool> isVpnNetworkActive() =>
      MobileSecuritySuitePlatform.instance.isVpnNetworkActive();

  @override
  Future<bool> isNetworkProxyEnabled() =>
      MobileSecuritySuitePlatform.instance.isNetworkProxyEnabled();

  @override
  Future<bool> isWifiConnectionSecure() =>
      MobileSecuritySuitePlatform.instance.isWifiConnectionSecure();

  @override
  Future<bool> isScreenMirroringActive() =>
      MobileSecuritySuitePlatform.instance.isScreenMirroringActive();

  @override
  Future<bool> isLocationMocked() =>
      MobileSecuritySuitePlatform.instance.isLocationMocked();

  @override
  Future<bool> enableTapJacking() =>
      MobileSecuritySuitePlatform.instance.enableTapJacking();

  @override
  Future<bool> disableTapJacking() =>
      MobileSecuritySuitePlatform.instance.disableTapJacking();

  @override
  Future<bool> enableScreenObfuscation() =>
      MobileSecuritySuitePlatform.instance.enableScreenObfuscation();

  @override
  Future<bool> disableScreenObfuscation() =>
      MobileSecuritySuitePlatform.instance.disableScreenObfuscation();

  static MobileSecuritySuite get instance =>
      _instance ??= MobileSecuritySuite._internal();

  void dispose() => _instance = null;    
}
