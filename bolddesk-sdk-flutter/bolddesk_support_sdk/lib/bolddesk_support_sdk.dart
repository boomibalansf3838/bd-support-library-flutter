import 'bolddesk_support_sdk_platform_interface.dart';

class BolddeskSupportSdk {
  static Future<void> initialize(
    String appId,
    String brandUrl, {
    void Function(String message)? onSuccess,
    void Function(String error)? onError,
  }) {
    return BolddeskSupportSdkPlatform.instance.initialize(
      appId,
      brandUrl,
      onSuccess: onSuccess,
      onError: onError,
    );
  }

  static Future<void> loginWithJWTToken(
    String jwtToken, {
    void Function(String message)? onSuccess,
    void Function(String error)? onError,
  }) {
    return BolddeskSupportSdkPlatform.instance.loginWithJWTToken(
      jwtToken,
      onSuccess: onSuccess,
      onError: onError,
    );
  }

  static Future<void> showHome() {
    return BolddeskSupportSdkPlatform.instance.showHome();
  }

  static Future<void> showKB() {
    return BolddeskSupportSdkPlatform.instance.showKB();
  }

  static Future<void> showCreateTicket() {
    return BolddeskSupportSdkPlatform.instance.showCreateTicket();
  }

  static Future<void> logout() {
    return BolddeskSupportSdkPlatform.instance.logout();
  }

  static Future<void> applyCustomFontFamilyInIOS(String fontFamily) {
    return BolddeskSupportSdkPlatform.instance.applyCustomFontFamilyInIOS(
      fontFamily,
    );
  }

  static Future<void> applyTheme(String accentColor, String primaryColor) {
    return BolddeskSupportSdkPlatform.instance.applyTheme(
      accentColor,
      primaryColor,
    );
  }

  static Future<void> setPreferredTheme(String theme) {
    return BolddeskSupportSdkPlatform.instance.setPreferredTheme(theme);
  }

  static Future<void> handleAndroidNotification(
    Map<String, dynamic> body,
    String notificationIcon,
  ) {
    return BolddeskSupportSdkPlatform.instance.handleAndroidNotification(
      body,
      notificationIcon,
    );
  }

  static Future<void> handleIOSNotification(Map<String, dynamic> data) async {
    await BolddeskSupportSdkPlatform.instance.handleIOSNotification(data);
  }

  static Future<void> setFCMRegistrationToken(String token) {
    return BolddeskSupportSdkPlatform.instance.setFCMRegistrationToken(token);
  }

  static Future<void> setLoggingEnabled(bool enable) {
    return BolddeskSupportSdkPlatform.instance.setLoggingEnabled(enable);
  }

  static Future<void> setSystemFontSize(bool enable) {
    return BolddeskSupportSdkPlatform.instance.setSystemFontSize(enable);
  }

  static Future<void> applyCustomFontFamilyInAndroid({
    required String regular,
    required String medium,
    required String semiBold,
    required String bold,
  }) {
    return BolddeskSupportSdkPlatform.instance.applyCustomFontFamilyInAndroid(
      regular: regular,
      medium: medium,
      semiBold: semiBold,
      bold: bold,
    );
  }
}

class BoldDeskSDKHome {
  static Future<void> setHeaderLogo(String logoURL) {
    return BolddeskSupportSdkPlatform.instance.setHeaderLogo(logoURL);
  }

  static Future<void> setHomeDashboardContent({
    String? headerName,
    String? headerDescription,
    String? kbTitle,
    String? kbDescription,
    String? ticketTitle,
    String? ticketDescription,
    String? submitButtonText,
  }) {
    return BolddeskSupportSdkPlatform.instance.setHomeDashboardContent(
      headerName: headerName,
      headerDescription: headerDescription,
      kbTitle: kbTitle,
      kbDescription: kbDescription,
      ticketTitle: ticketTitle,
      ticketDescription: ticketDescription,
      submitButtonText: submitButtonText,
    );
  }
}
