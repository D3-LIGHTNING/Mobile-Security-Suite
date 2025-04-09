import 'platform_interface.dart';

class MobileSecuritySuite implements MobileSecuritySuitePlatform {
  const MobileSecuritySuite._internal();
  static MobileSecuritySuite? _instance;

  /// Checks whether the current running device is compromised via rooting (Android)
  /// or jailbreaking (iOS).
  ///
  /// This method relies on the Flutter plugin [`jailbreak_root_detection`](https://pub.dev/packages/jailbreak_root_detection),
  /// specifically the `JailbreakRootDetection.instance.isJailBroken` method
  /// as the underlying implementation.
  ///
  /// **Return value:**
  /// - `true`  → Device is compromised
  /// - `false` → Device is not compromised
  ///
  /// **Supported Platforms:** Android and iOS
  ///
  /// Overridden from `MobileSecuritySuitePlatform`.
  @override
  Future<bool> isDeviceCompromised() =>
      MobileSecuritySuitePlatform.instance.isDeviceCompromised();

  /// Checks whether the currently running device is a physical device or an emulator.
  ///
  /// This method relies on the Flutter plugin [`jailbreak_root_detection`](https://pub.dev/packages/jailbreak_root_detection),
  /// specifically the `JailbreakRootDetection.instance.isRealDevice` method
  /// as the underlying implementation.
  ///
  /// **Return value:**
  /// - `true`  → Device is a physical device
  /// - `false` → Device is an emulator
  ///
  /// **Supported Platforms:** Android and iOS
  ///
  /// Overridden from `MobileSecuritySuitePlatform`.
  @override
  Future<bool> isRunningOnPhysicalDevice() =>
      MobileSecuritySuitePlatform.instance.isRunningOnPhysicalDevice();

  /// Checks whether the device is in a debug-enabled state, such as having ADB enabled
  /// or the system waiting for a debugger to attach to the application.
  ///
  /// This method relies on the Flutter plugin [`jailbreak_root_detection`](https://pub.dev/packages/jailbreak_root_detection),
  /// specifically the `JailbreakRootDetection.instance.isDebugged` method
  /// as the underlying implementation, which checks Android system debug flags.
  ///
  /// **Return value:**
  /// - `true`  → Device has debugging enabled (e.g., ADB or debugger is attached)
  /// - `false` → Device is not in a debug-enabled state
  ///
  /// **Supported Platforms:** Android and iOS
  ///
  /// Overridden from `MobileSecuritySuitePlatform`
  @override
  Future<bool> isDeviceDebugging() =>
      MobileSecuritySuitePlatform.instance.isDeviceDebugging();

  /// Checks whether developer options are enabled on the currently running device.
  ///
  /// This method relies on the Flutter plugin [`jailbreak_root_detection`](https://pub.dev/packages/jailbreak_root_detection),
  /// specifically the `JailbreakRootDetection.instance.isDevMode` method
  /// as the underlying implementation.
  ///
  /// **Return value:**
  /// - `true`  → Developer options are enabled
  /// - `false` → Developer options are disabled
  /// - On iOS, this method always returns `false`
  ///
  /// **Supported Platforms:** Android only
  ///
  /// Overridden from `MobileSecuritySuitePlatform`.
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
