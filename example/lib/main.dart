import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_security_suite/mobile_security_suite.dart';
import 'package:permission_handler/permission_handler.dart';

void main() => runApp(const MobileSecuritySuiteExample());

class MobileSecuritySuiteExample extends StatelessWidget {
  const MobileSecuritySuiteExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtil(
      options: ScreenUtilOptions(
        enable: true,
        fontFactorByWidth: 2.0,
        fontFactorByHeight: 1.0,
        flipSizeWhenLandscape: true,
        designSize: Size(392.7, 826.9),
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(useMaterial3: true),
        darkTheme: ThemeData.dark(useMaterial3: true),
        themeMode: ThemeMode.dark,
        home: MobileSecuritySuiteHome(),
      ),
    );
  }
}

class MobileSecuritySuiteHome extends StatefulWidget {
  const MobileSecuritySuiteHome({super.key});

  @override
  State<MobileSecuritySuiteHome> createState() =>
      _MobileSecuritySuiteHomeState();
}

class _MobileSecuritySuiteHomeState extends State<MobileSecuritySuiteHome> {
  void showStatusSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message,
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(fontWeight: FontWeight.w600)),
        backgroundColor: const Color.fromARGB(255, 17, 22, 28),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Mobile security suite example",
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.w600, fontSize: context.sp(19)),
        ),
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 10,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: context.w(16)),
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SecurityDisplayCard(
              title: "Device Compromised",
              description:
                  "Check if your device is compromised by root clocking or jail breaking.",
              buttonTitle: "Check state",
              onButtonPressed: () async {
                if (await MobileSecuritySuite.instance.isDeviceCompromised()) {
                  showStatusSnackBar("Device is compromised");
                } else {
                  showStatusSnackBar("Device not compromised");
                }
              },
            ),
            FixedSpacer(),
            SecurityDisplayCard(
              title: "Physical Device",
              description:
                  "Check if the application is running on a Physical device and not an Emulator or Virtual device.",
              buttonTitle: "Check state",
              onButtonPressed: () async {
                if (await MobileSecuritySuite.instance
                    .isRunningOnPhysicalDevice()) {
                  showStatusSnackBar(
                      "Application is running on a Physical device");
                } else {
                  showStatusSnackBar(
                      "Application is not running on a Physical device");
                }
              },
            ),
            FixedSpacer(),
            SecurityDisplayCard(
              title: "Device debugging",
              description: "Check if device is being debugged by a Debugger.",
              buttonTitle: "Check state",
              onButtonPressed: () async {
                if (await MobileSecuritySuite.instance.isDeviceDebugging()) {
                  showStatusSnackBar("Device is being debugged");
                } else {
                  showStatusSnackBar("Device is not being debugged");
                }
              },
            ),
            FixedSpacer(),
            SecurityDisplayCard(
              title: "Developer options",
              description: "Check if Developer options are enabled.",
              buttonTitle: "Check state",
              onButtonPressed: () async {
                if (await MobileSecuritySuite.instance
                    .isDeveloperOptionsEnabled()) {
                  showStatusSnackBar("Developer options are enabled");
                } else {
                  showStatusSnackBar("Developer options are not enabled");
                }
              },
            ),
            FixedSpacer(),
            SecurityDisplayCard(
              title: "External storage",
              description: "Check if running on external storage.",
              buttonTitle: "Check state",
              onButtonPressed: () async {
                if (await MobileSecuritySuite.instance.isOnExternalStorage()) {
                  showStatusSnackBar(
                      "Application is running on external storage");
                } else {
                  showStatusSnackBar(
                      "Application is not running on external storage");
                }
              },
            ),
            FixedSpacer(),
            SecurityDisplayCard(
              title: "VPN Network",
              description: "Check if device is connected through VPN Network.",
              buttonTitle: "Check state",
              onButtonPressed: () async {
                if (await MobileSecuritySuite.instance.isVpnNetworkActive()) {
                  showStatusSnackBar("Device is connected through VPN Network");
                } else {
                  showStatusSnackBar(
                      "Device is not connected through VPN Network");
                }
              },
            ),
            FixedSpacer(),
            SecurityDisplayCard(
              title: "Proxy Enabled",
              description:
                  "Check if device is connected through Proxy Network.",
              buttonTitle: "Check state",
              onButtonPressed: () async {
                if (await MobileSecuritySuite.instance
                    .isNetworkProxyEnabled()) {
                  showStatusSnackBar(
                      "Device is connected through Proxy Network");
                } else {
                  showStatusSnackBar(
                      "Device is not connected through Proxy Network");
                }
              },
            ),
            FixedSpacer(),
            SecurityDisplayCard(
              title: "WIFI Security",
              description:
                  "Check if the WIFI Network your device is connected to is secure.",
              buttonTitle: "Check state",
              onButtonPressed: () async {
                if (await MobileSecuritySuite.instance
                    .isWifiConnectionSecure()) {
                  showStatusSnackBar(
                      "Device is either not connected to a Wifi Network or is connected to a secure Wifi Network");
                } else {
                  showStatusSnackBar(
                      "Device is connected to an unsecure Wifi Network");
                }
              },
            ),
            FixedSpacer(),
            SecurityDisplayCard(
              title: "Screen Mirroring",
              description: "Check if device Screen Mirroring is active.",
              buttonTitle: "Check state",
              onButtonPressed: () async {
                if (await MobileSecuritySuite.instance
                    .isScreenMirroringActive()) {
                  showStatusSnackBar("Device is Screen Mirroing");
                } else {
                  showStatusSnackBar("Device is not Screen Mirroring");
                }
              },
            ),
            FixedSpacer(),
            SecurityDisplayCard(
              title: "Mock Location",
              description: "Check if location is being mocked on the device.",
              buttonTitle: "Check state",
              onButtonPressed: () async {
                await Permission.location.request();
                if (await MobileSecuritySuite.instance.isLocationMocked()) {
                  showStatusSnackBar("Location is being mocked");
                } else {
                  showStatusSnackBar("Location is not mocked");
                }
              },
            ),
            FixedSpacer(),
            Divider(thickness: 2),
            FixedSpacer(),
            StateHoldingSecurityDisplayCard(
              title: "Tap Jacking",
              description: "Enable or disable Tap Jacking blocking.",
              onButtonPressed: (enabled) async {
                if (enabled) {
                  if (await MobileSecuritySuite.instance.disableTapJacking()) {
                    showStatusSnackBar(
                        "Tap Jacking prevention is now disabled");
                    return true;
                  }
                } else {
                  if (await MobileSecuritySuite.instance.enableTapJacking()) {
                    showStatusSnackBar("Tap Jacking prevention is now enabled");
                    return true;
                  }
                }
                return false;
              },
            ),
            FixedSpacer(),
            StateHoldingSecurityDisplayCard(
              title: "Screen Obfuscation",
              description:
                  "Enable or disable Screen Obfuscation, ScreenShot blocking, ScreenRecord blocking.",
              onButtonPressed: (enabled) async {
                if (enabled) {
                  if (await MobileSecuritySuite.instance
                      .disableScreenObfuscation()) {
                    showStatusSnackBar("Screen Obfuscation is now disabled");
                    return true;
                  }
                } else {
                  if (await MobileSecuritySuite.instance
                      .enableScreenObfuscation()) {
                    showStatusSnackBar("Screen Obfuscation is now enabled");
                    return true;
                  }
                }
                return false;
              },
            ),
            FixedSpacer(),
          ],
        ),
      ),
    );
  }
}

class StateHoldingSecurityDisplayCard extends StatefulWidget {
  final String title;
  final String description;
  final Future<bool> Function(bool enabled) onButtonPressed;
  const StateHoldingSecurityDisplayCard({
    required this.title,
    required this.description,
    required this.onButtonPressed,
    super.key,
  });

  @override
  State<StateHoldingSecurityDisplayCard> createState() =>
      _StateHoldingSecurityDisplayCardState();
}

class _StateHoldingSecurityDisplayCardState
    extends State<StateHoldingSecurityDisplayCard> {
  bool enabled = false;

  @override
  Widget build(BuildContext context) {
    return SecurityDisplayCard(
      title: widget.title,
      description: widget.description,
      onButtonPressed: () async {
        bool done = await widget.onButtonPressed(enabled);
        if (done) setState(() => enabled = !enabled);
      },
      buttonTitle: enabled ? "Disable" : "Enable",
    );
  }
}

class FixedSpacer extends StatelessWidget {
  const FixedSpacer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: context.h(30));
  }
}

class SecurityDisplayCard extends StatelessWidget {
  final VoidCallback onButtonPressed;
  final String title;
  final String description;
  final String buttonTitle;

  const SecurityDisplayCard({
    required this.title,
    required this.description,
    required this.onButtonPressed,
    required this.buttonTitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: context.h(100)),
      width: double.maxFinite,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(context.r(3)),
          color: const Color.fromARGB(255, 34, 40, 53)),
      padding: EdgeInsets.all(context.i(11)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(title,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.w600)),
          SizedBox(height: context.h(10)),
          Text(description,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.w600)),
          SizedBox(height: context.h(10)),
          SizedBox(
            width: double.maxFinite,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 51, 71, 89),
                  textStyle: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.w600),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(context.r(3)))),
              onPressed: onButtonPressed,
              child: Text(buttonTitle),
            ),
          )
        ],
      ),
    );
  }
}
