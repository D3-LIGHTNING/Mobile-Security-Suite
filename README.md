# mobile_security_suite

A Flutter plugin to fortify your mobile apps against common threats like rooted devices, emulators, debuggers, proxy/VPN usage, and more.

Protect your users. Secure your app. Sleep better 😌

## 🌟 Features

✅ Root/Jailbreak Detection

📱 Emulator Detection

🐞 Debug Mode Detection

🛠️ Developer Options Status

💽 External Storage Check

🌐 VPN & Proxy Detection

📶 Wi-Fi Security Check

📺 Screen Mirroring Detection

🗺️ Mock Location Detection

☠️ Tapjacking Protection

🚫 Screen Obfuscation (Block screenshots/recording)

## 🚀 Getting Started

Until this package is published on pub.dev, you can use it by referencing the GitHub repository directly:

``` yaml
dependencies:
  mobile_security_suite:
    git:
      url: https://github.com/D3-LIGHTNING/Mobile-Security-Suite.git
      ref: main    
```

### Android

The plugin uses the below Permissions. 

```xml
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
<uses-permission android:name="android.permission.HIDE_OVERLAY_WINDOWS" />
```    

However you don't have to add these permissions in to your "AndroidManifest.xml" file since these permissions are already added in the plugin itself.

### iOS

- Update `Info.plist`

```xml
<key>LSApplicationQueriesSchemes</key>
<array>
    <string>undecimus</string>
    <string>sileo</string>
    <string>zbra</string>
    <string>filza</string>
    <string>activator</string>
    <string>cydia</string>
</array>
```

## Usage

``` dart
import 'package:mobile_security_suite/mobile_security_suite.dart';

void checkSecurity() async {
  final suite = MobileSecuritySuite.instance;

  if (await suite.isDeviceCompromised()) {
    print("Device is compromised (rooted/jailbroken)");
  }
}
```

The "isLocationMocked" API requires Location permissions to operate. You can use "permission_handler" plugin to request Permissions like this.

``` dart
await Permission.location.request();

if (await MobileSecuritySuite.instance.isLocationMocked()) {
    showStatusSnackBar("Location is being mocked");
} else {
    showStatusSnackBar("Location is not mocked");
}
```

📘 API Overview

Each method returns a Future<bool> and is platform-aware:

| Method                        | Description                                                                     | Platforms    | Returns                                |
| ----------------------------- | ------------------------------------------------------------------------------- | ------------ | -------------------------------------- |
| `isDeviceCompromised()`       | Checks if device is rooted (Android) or jailbroken (iOS).                       | Android, iOS | `Future<bool>` (`true` if compromised) |
| `isRunningOnPhysicalDevice()` | Checks if the device is a physical device or emulator.                          | Android, iOS | `Future<bool>` (`true` if physical)    |
| `isDeviceDebugging()`         | Detects if debugging (e.g., ADB) is enabled.                                    | Android, iOS | `Future<bool>`                         |
| `isDeveloperOptionsEnabled()` | Checks if developer options are enabled (always `false` on iOS).                | Android only | `Future<bool>`                         |
| `isOnExternalStorage()`       | Checks if app is installed on external storage (always `false` on iOS).         | Android only | `Future<bool>`                         |
| `isVpnNetworkActive()`        | Checks if device is connected to a VPN.                                         | Android, iOS | `Future<bool>`                         |
| `isNetworkProxyEnabled()`     | Checks if device is connected through a proxy.                                  | Android, iOS | `Future<bool>`                         |
| `isWifiConnectionSecure()`    | Checks if Wi-Fi connection is secure (always `true` on iOS).                    | Android only | `Future<bool>`                         |
| `isScreenMirroringActive()`   | Checks if screen mirroring is active.                                           | Android, iOS | `Future<bool>`                         |
| `isLocationMocked()`          | Detects if device location is mocked/spoofed.                                   | Android, iOS | `Future<bool>`                         |
| `enableTapJacking()`          | Enables tapjacking protection (always `true` on iOS).                           | Android only | `Future<bool>`                         |
| `disableTapJacking()`         | Disables tapjacking protection (always `true` on iOS).                          | Android only | `Future<bool>`                         |
| `enableScreenObfuscation()`   | Enables screen obfuscation to block screenshots/recordings (iOS always `true`). | Android only | `Future<bool>`                         |
| `disableScreenObfuscation()`    |  Disables screen obfuscation (iOS always `true`).      | Android only          | `Future<bool>`                             |


💡 Use Case Examples

Block logins from compromised or emulated devices 🧪

Disable app functionality over VPN or insecure Wi-Fi 🌐

Detect screen recording on sensitive screens 🎥

Avoid tapjacking on transaction/PIN entry UIs 🔒

🤝 Contributions

Contributions, issues, and feature requests are welcome! Feel free to open an issue or submit a PR 💌

# Made with ❤️ and security paranoia by D3-LIGHTNING 🛡️✨

