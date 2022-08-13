import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_upgrade_version/flutter_upgrade_version.dart';

void main() {
  const MethodChannel channel = MethodChannel('flutter_upgrade_version');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await FlutterUpgradeVersion.platformVersion, '42');
  });
}
