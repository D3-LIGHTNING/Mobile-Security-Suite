import 'platform_interface.dart';

/// Dart API Interface of MobileSecuritySuite Plugin.
class MobileSecuritySuite implements MobileSecuritySuitePlatform {
  // Private constructor of MobileSecuritySuite.
  const MobileSecuritySuite._internal();
  // Private and static instance of MobileSecuritySuite.
  // This instance by nature nullable and is null until the first call to `MobileSecuritySuite.instance`.
  // This pattern is implemented to aquire lazy loaded instance of MobileSecuritySuite.
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
  ///
  /// **iOS Note:** On iOS, this method always returns `false`
  ///
  /// **Supported Platforms:** Android only
  ///
  /// Overridden from `MobileSecuritySuitePlatform`.
  @override
  Future<bool> isDeveloperOptionsEnabled() =>
      MobileSecuritySuitePlatform.instance.isDeveloperOptionsEnabled();

  /// Checks whether the current application is installed on external storage (e.g., SD card).
  ///
  /// This method relies on the Flutter plugin [`jailbreak_root_detection`](https://pub.dev/packages/jailbreak_root_detection),
  /// specifically the `JailbreakRootDetection.instance.isOnExternalStorage` method
  /// as the underlying implementation.
  ///
  /// **Return value:**
  /// - `true`  → The app is installed on external storage
  /// - `false` → The app is installed on internal storage
  ///
  /// **iOS Note:** On iOS, this method always returns `false`
  ///
  /// **Supported Platforms:** Android only
  ///
  /// Overridden from `MobileSecuritySuitePlatform`.
  @override
  Future<bool> isOnExternalStorage() =>
      MobileSecuritySuitePlatform.instance.isOnExternalStorage();

  /// Checks whether the device is currently connected to the internet through a VPN.
  ///
  /// **Return value:**
  /// - `true`  → A VPN connection is active
  /// - `false` → No VPN connection is active
  ///
  /// **Supported Platforms:** Android and iOS
  ///
  /// Overridden from `MobileSecuritySuitePlatform`.
  @override
  Future<bool> isVpnNetworkActive() =>
      MobileSecuritySuitePlatform.instance.isVpnNetworkActive();

  /// Checks whether the device is currently connected to the internet through a proxy.
  ///
  /// **Return value:**
  /// - `true`  → A proxy connection is active
  /// - `false` → No proxy connection is active
  ///
  /// **Supported Platforms:** Android and iOS
  ///
  /// Overridden from `MobileSecuritySuitePlatform`.
  @override
  Future<bool> isNetworkProxyEnabled() =>
      MobileSecuritySuitePlatform.instance.isNetworkProxyEnabled();

  /// Checks whether the device is currently connected to a secure Wi-Fi network.
  ///
  /// **Return value:**
  /// - `true`  → The device is either connected to a **secure Wi-Fi network** or **not connected to any Wi-Fi network at all**
  /// - `false` → The device is connected to an **unsecure Wi-Fi network**
  ///
  /// This method is designed such that the calling code only needs to act when the return value is `false`.
  ///
  /// A `false` result indicates a definite unsecure Wi-Fi connection.
  ///
  /// A `true` result means either:
  ///   - The device is not using Wi-Fi (hence, no threat), or
  ///   - The device is connected to a secure Wi-Fi network.
  ///
  /// **iOS Note:** On iOS, this method always returns `true`, as checking Wi-Fi security is not supported.
  ///
  /// **Supported Platforms:** Android only
  ///
  /// Overridden from `MobileSecuritySuitePlatform`.
  @override
  Future<bool> isWifiConnectionSecure() =>
      MobileSecuritySuitePlatform.instance.isWifiConnectionSecure();

  /// Checks whether the screen of the device is currently being mirrored to another display
  /// via technologies like Miracast for Android or AirPlay for iOS.
  ///
  /// **Return value:**
  /// - `true`  → Screen mirroring is currently active
  /// - `false` → No screen mirroring detected
  ///
  /// **Supported Platforms:** Android and iOS
  ///
  /// Overridden from `MobileSecuritySuitePlatform`.
  @override
  Future<bool> isScreenMirroringActive() =>
      MobileSecuritySuitePlatform.instance.isScreenMirroringActive();

  /// Checks whether the device is reporting a mocked (fake/spoofed) location.
  ///
  /// This is useful for detecting apps or tools that attempt to trick the device into
  /// reporting false location data, which could be a sign of location spoofing tools
  /// like Fake GPS apps.
  ///
  /// **Return value:**
  /// - `true`  → Mock location is active (location is being faked/spoofed)
  /// - `false` → Device location appears to be genuine
  ///
  /// **Supported Platforms:** Android and iOS
  ///
  /// Overridden from `MobileSecuritySuitePlatform`.
  @override
  Future<bool> isLocationMocked() =>
      MobileSecuritySuitePlatform.instance.isLocationMocked();

  /// Enables **tapjacking prevention** for the application.
  ///
  /// Tapjacking is a malicious technique where invisible elements are layered over your app
  /// to trick users into tapping something they didn’t intend to.
  ///
  /// This feature should be enabled in screens where sensitive user interaction occurs
  /// (e.g., login, payment, PIN input).
  ///
  /// **Return value:**
  /// - `true`  → Tapjacking prevention enabled successfully
  /// - `false` → Failed to apply tapjacking protection
  ///
  /// **iOS Note:** On iOS, this method always returns `true`.
  ///
  /// **Supported Platforms:** Android only
  ///
  /// Overridden from `MobileSecuritySuitePlatform`.
  @override
  Future<bool> enableTapJacking() =>
      MobileSecuritySuitePlatform.instance.enableTapJacking();

  /// Disables **tapjacking prevention** for the application.
  ///
  /// **Return value:**
  /// - `true`  → Tapjacking prevention disabled successfully
  /// - `false` → Failed to disable tapjacking protection
  ///
  /// **iOS Note:** On iOS, this method always returns `true`.
  ///
  /// **Supported Platforms:** Android only
  ///
  /// See [enableTapJacking] for more info.
  ///
  /// Overridden from `MobileSecuritySuitePlatform`.
  @override
  Future<bool> disableTapJacking() =>
      MobileSecuritySuitePlatform.instance.disableTapJacking();

  /// Enables **screen obfuscation** to prevent sensitive information from being captured
  /// via screenshots or screen recordings.
  ///
  /// When this feature is enabled, the system will treat the app's window as secure,
  /// which blocks:
  /// - Screenshots
  /// - Screen recordings
  /// - Android "Recents" thumbnails showing app content
  ///
  /// **Use Case:** Enable this on screens that show sensitive user data, like
  /// authentication flows, personal info, or financial transactions.
  ///
  /// **Return value:**
  /// - `true`  → Screen obfuscation enabled successfully
  /// - `false` → Failed to apply obfuscation
  ///
  /// **iOS Note:** On iOS, this method always returns `true`.
  ///
  /// **Supported Platforms:** Android only
  ///
  /// Overridden from `MobileSecuritySuitePlatform`.
  @override
  Future<bool> enableScreenObfuscation() =>
      MobileSecuritySuitePlatform.instance.enableScreenObfuscation();

  /// Disables **screen obfuscation**, allowing the app's UI to be visible from:
  /// - Screenshots
  /// - Screen recordings
  /// - Android "Recents" thumbnails showing app content
  ///
  /// **Return value:**
  /// - `true`  → Screen obfuscation disabled successfully
  /// - `false` → Failed to disable obfuscation
  ///
  /// **iOS Note:** On iOS, this method always returns `true`.
  ///
  /// **Supported Platforms:** Android only
  ///
  /// See [enableScreenObfuscation] for more info.
  ///
  /// Overridden from `MobileSecuritySuitePlatform`.
  @override
  Future<bool> disableScreenObfuscation() =>
      MobileSecuritySuitePlatform.instance.disableScreenObfuscation();

  /// Provides a singleton instance of [MobileSecuritySuite].
  ///
  /// This ensures that all calls throughout the application refer to the same
  /// underlying instance of the security suite, maintaining consistency.
  ///
  /// Internally uses Dart’s lazy initialization pattern (`??=`).
  ///
  /// **Usage Example:**
  /// ```dart
  /// final security = MobileSecuritySuite.instance;
  /// ```
  ///
  /// Use this to access security-related checks and actions across your app.
  static MobileSecuritySuite get instance =>
      _instance ??= MobileSecuritySuite._internal();

  /// Clears the internal [MobileSecuritySuite] singleton instance.
  ///
  /// After calling this method, a new instance will be lazily created
  /// the next time [MobileSecuritySuite.instance] is accessed.
  ///
  /// Useful in scenarios like user logout or app state resets.
  ///
  /// Lightweight and safe to call when needed.
  void dispose() => _instance = null;
}
