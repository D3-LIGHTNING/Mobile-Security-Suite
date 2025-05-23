MobileSecuritySuite 🔐

A Flutter plugin to fortify your mobile apps against common threats like rooted devices, emulators, debuggers, proxy/VPN usage, and more.

Protect your users. Secure your data. Sleep better 😌

🌟 Features

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

📦 Installation

Until this package is published on pub.dev, you can use it by referencing the GitHub repository directly:

dependencies:
  mobile_security_suite:
    git:
      url: https://github.com/your-org/mobile_security_suite.git

Then run:

flutter pub get

🚀 Getting Started

import 'package:mobile_security_suite/mobile_security_suite.dart';

void checkSecurity() async {
  final suite = MobileSecuritySuite.instance;

  if (await suite.isDeviceCompromised()) {
    print("Device is compromised (rooted/jailbroken)");
  }
}

To disable the singleton (e.g., on logout):

MobileSecuritySuite.instance.dispose();

📘 API Overview

Each method returns a Future<bool> and is platform-aware:

Method

Description

Android

iOS

isDeviceCompromised()

Checks for root/jailbreak

✅

✅

isRunningOnPhysicalDevice()

Physical device vs emulator

✅

✅

isDeviceDebugging()

Debug/ADB enabled check

✅

✅

isDeveloperOptionsEnabled()

Checks if Dev Options are enabled

✅

❌ Always false

isOnExternalStorage()

App installed on external storage

✅

❌ Always false

isVpnNetworkActive()

VPN connection check

✅

✅

isNetworkProxyEnabled()

Proxy detection

✅

✅

isWifiConnectionSecure()

Secure Wi-Fi check

✅

❌ Always true

isScreenMirroringActive()

Screen mirroring detection

✅

✅

isLocationMocked()

Fake GPS / mock location detection

✅

✅

enableTapJacking()

Protect against tapjacking

✅

✅ Always true

disableTapJacking()

Disable tapjacking protection

✅

✅ Always true

enableScreenObfuscation()

Prevent screenshots/recording

✅

✅ Always true

disableScreenObfuscation()

Allow screenshots/recording

✅

✅ Always true

💡 Use Case Examples

Block logins from compromised or emulated devices 🧪

Disable app functionality over VPN or insecure Wi-Fi 🌐

Detect screen recording on sensitive screens 🎥

Avoid tapjacking on transaction/PIN entry UIs 🔒

🤝 Contributions

Contributions, issues, and feature requests are welcome! Feel free to open an issue or submit a PR 💌

📄 License

MIT License

Made with ❤️ and security paranoia by Pradhu 🛡️✨

