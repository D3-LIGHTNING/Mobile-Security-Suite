// import 'package:flutter/services.dart';
// import 'package:flutter_test/flutter_test.dart';
// // import 'package:mobile_security_suite/mobile_security_suite_method_channel.dart';

// void main() {
//   TestWidgetsFlutterBinding.ensureInitialized();

//   // MethodChannelMobileSecuritySuite platform = MethodChannelMobileSecuritySuite();
//   const MethodChannel channel = MethodChannel('mobile_security_suite');

//   setUp(() {
//     TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
//       channel,
//       (MethodCall methodCall) async {
//         return '42';
//       },
//     );
//   });

//   tearDown(() {
//     TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
//   });

//   test('getPlatformVersion', () async {
//     // expect(await platform.getPlatformVersion(), '42');
//   });
// }
