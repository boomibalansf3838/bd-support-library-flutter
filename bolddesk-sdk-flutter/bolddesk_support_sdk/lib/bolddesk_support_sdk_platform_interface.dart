import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'bolddesk_support_sdk_method_channel.dart';

abstract class BolddeskSupportSdkPlatform extends PlatformInterface {
  /// Constructs a BolddeskSupportSdkPlatform.
  BolddeskSupportSdkPlatform() : super(token: _token);

  static final Object _token = Object();

  static BolddeskSupportSdkPlatform _instance =
      MethodChannelBolddeskSupportSdk();

  /// The default instance of [BolddeskSupportSdkPlatform] to use.
  ///
  /// Defaults to [MethodChannelBolddeskSupportSdk].
  static BolddeskSupportSdkPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [BolddeskSupportSdkPlatform] when
  /// they register themselves.
  static set instance(BolddeskSupportSdkPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> initialize(
    String appId,
    String brandUrl, {
    void Function(String message)? onSuccess,
    void Function(String error)? onError,
  }) {
    throw UnimplementedError('initialize() has not been implemented.');
  }

  Future<void> loginWithJWTToken(
    String jwtToken, {
    void Function(String message)? onSuccess,
    void Function(String error)? onError,
  }) {
    throw UnimplementedError('initialize() has not been implemented.');
  }

  Future<void> showHome() {
    throw UnimplementedError('showHome() has not been implemented.');
  }

  Future<void> showKB() {
    throw UnimplementedError('showKB() has not been implemented.');
  }

  Future<void> showCreateTicket() {
    throw UnimplementedError('showCreateTicket() has not been implemented.');
  }

  Future<void> logout() {
    throw UnimplementedError('logout() has not been implemented.');
  }

  Future<void> applyCustomFontFamilyInIOS(String fontFamily) {
    throw UnimplementedError(
      'applyCustomFontFamilyInIOS() has not been implemented.',
    );
  }

  Future<void> applyTheme(String accentColor, String primaryColor) async {
    throw UnimplementedError('applyTheme() has not been implemented.');
  }

  Future<void> setPreferredTheme(String theme) async {
    throw UnimplementedError('setPreferredTheme() has not been implemented.');
  }

  Future<void> handleAndroidNotification(
    Map<String, dynamic> body,
    String notificationIcon,
  );

  Future<void> setFCMRegistrationToken(String token) {
    throw UnimplementedError(
      'setFCMRegistrationToken() has not been implemented.',
    );
  }

  Future<void> handleIOSNotification(Map<String, dynamic> data) {
    throw UnimplementedError('handleNotification() has not been implemented.');
  }

  Future<void> setLoggingEnabled(bool enable) {
    throw UnimplementedError('setLoggingEnabled() has not been implemented.');
  }

  Future<void> setSystemFontSize(bool enable) {
    throw UnimplementedError('setSystemFontSize() has not been implemented.');
  }

  Future<void> setHeaderLogo(String logoURL) async {
    throw UnimplementedError('setHeaderLogo() has not been implemented.');
  }

  Future<void> setHomeDashboardContent({
    String? headerName,
    String? headerDescription,
    String? kbTitle,
    String? kbDescription,
    String? ticketTitle,
    String? ticketDescription,
    String? submitButtonText,
  }) async {
    throw UnimplementedError(
      'setHomeDashboardContent() has not been implemented.',
    );
  }

  Future<void> applyCustomFontFamilyInAndroid({
    required String regular,
    required String medium,
    required String semiBold,
    required String bold,
  }) {
    throw UnimplementedError(
      'applyCustomFontFamilyInAndroid() has not been implemented.',
    );
  }
}
