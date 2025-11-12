import 'package:flutter_test/flutter_test.dart';
import 'package:bolddesk_support_sdk/bolddesk_support_sdk_platform_interface.dart';
import 'package:bolddesk_support_sdk/bolddesk_support_sdk_method_channel.dart';

void main() {
  final BolddeskSupportSdkPlatform initialPlatform = BolddeskSupportSdkPlatform.instance;

  test('$MethodChannelBolddeskSupportSdk is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelBolddeskSupportSdk>());
  });
}
