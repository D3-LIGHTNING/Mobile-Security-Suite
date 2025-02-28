// import 'package:flutter_test/flutter_test.dart';
// // import 'package:mobile_security_suite/mobile_security_suite.dart';
// import 'package:mobile_security_suite/mobile_security_suite_platform_interface.dart';
// import 'package:mobile_security_suite/mobile_security_suite_method_channel.dart';
// import 'package:plugin_platform_interface/plugin_platform_interface.dart';

// class MockMobileSecuritySuitePlatform
//     with MockPlatformInterfaceMixin
//     implements MobileSecuritySuitePlatform {

//   @override
//   Future<String?> getPlatformVersion() => Future.value('42');
// }

// void main() {
//   final MobileSecuritySuitePlatform initialPlatform = MobileSecuritySuitePlatform.instance;

//   test('$MethodChannelMobileSecuritySuite is the default instance', () {
//     expect(initialPlatform, isInstanceOf<MethodChannelMobileSecuritySuite>());
//   });

//   test('getPlatformVersion', () async {
//     // MobileSecuritySuite mobileSecuritySuitePlugin = MobileSecuritySuite();
//     MockMobileSecuritySuitePlatform fakePlatform = MockMobileSecuritySuitePlatform();
//     MobileSecuritySuitePlatform.instance = fakePlatform;

//     // expect(await mobileSecuritySuitePlugin.getPlatformVersion(), '42');
//   });
// }
