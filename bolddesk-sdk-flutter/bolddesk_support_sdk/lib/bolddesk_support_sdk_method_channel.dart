import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'bolddesk_support_sdk_platform_interface.dart';

/// An implementation of [BolddeskSupportSdkPlatform] that uses method channels.
class MethodChannelBolddeskSupportSdk extends BolddeskSupportSdkPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('bolddesk_support_sdk');

  @override
  Future<void> initialize(
    String appId,
    String brandUrl, {
    void Function(String message)? onSuccess,
    void Function(String error)? onError,
  }) async {
    try {
      final result = await methodChannel.invokeMethod('initialize', {
        'appId': appId,
        'brandUrl': brandUrl,
      });
      if (result != null) {
        final success = result['success'] as bool? ?? false;
        final message = result['message'] as String? ?? '';

        if (success) {
          if (onSuccess != null) onSuccess(message);
        } else {
          if (onError != null) onError(message);
        }
      } else {
        if (onError != null) onError('No response from SDK');
      }
    } on PlatformException catch (e) {
      if (onError != null) onError(e.message ?? 'Unknown error');
    }
  }

  @override
  Future<void> loginWithJWTToken(
    String jwtToken, {
    void Function(String message)? onSuccess,
    void Function(String error)? onError,
  }) async {
    try {
      final result = await methodChannel.invokeMethod('loginWithJWTToken', {
        'jwtToken': jwtToken,
      });
      if (result != null) {
        final success = result['success'] as bool? ?? false;
        final message = result['message'] as String? ?? '';

        if (success) {
          if (onSuccess != null) onSuccess(message);
        } else {
          if (onError != null) onError(message);
        }
      } else {
        if (onError != null) onError('No response from SDK');
      }
    } on PlatformException catch (e) {
      if (onError != null) onError(e.message ?? 'Unknown error');
    }
  }

  @override
  Future<void> applyCustomFontFamilyInIOS(String fontFamily) async {
    await methodChannel.invokeMethod('applyCustomFontFamilyInIOS', {
      'fontFamily': fontFamily,
    });
  }

  @override
  Future<void> applyTheme(String accentColor, String primaryColor) async {
    await methodChannel.invokeMethod('applyTheme', {
      'accentColor': accentColor,
      'primaryColor': primaryColor,
    });
  }

  @override
  Future<void> setPreferredTheme(String theme) async {
    await methodChannel.invokeMethod('setPreferredTheme', {'theme': theme});
  }

  @override
  Future<void> showHome() async {
    await methodChannel.invokeMethod('showHomeDashboard');
  }

  @override
  Future<void> showKB() async {
    await methodChannel.invokeMethod('showKB');
  }

  @override
  Future<void> showCreateTicket() async {
    await methodChannel.invokeMethod('showCreateTicket');
  }

  @override
  Future<void> logout() async {
    await methodChannel.invokeMethod('logout');
  }

  @override
  Future<void> handleAndroidNotification(
    Map<String, dynamic> body,
    String icon,
  ) async {
    await methodChannel.invokeMethod('showNotification', {
      'body': body,
      'icon': icon,
    });
  }

  @override
  Future<void> setFCMRegistrationToken(String token) async {
    await methodChannel.invokeMethod('setFCMRegistrationToken', {
      'token': token,
    });
  }

  @override
  Future<void> handleIOSNotification(Map<String, dynamic> data) async {
    await methodChannel.invokeMethod('handleNotification', data);
  }

  @override
  Future<void> setLoggingEnabled(bool enable) async {
    await methodChannel.invokeMethod('setLoggingEnabled', {'enable': enable});
  }

  @override
  Future<void> setSystemFontSize(bool enable) async {
    await methodChannel.invokeMethod('setSystemFontSize', {'enable': enable});
  }

  @override
  Future<void> setHeaderLogo(String logoURL) async {
    await methodChannel.invokeMethod('setHeaderLogo', {'logoURL': logoURL});
  }

  @override
  Future<void> setHomeDashboardContent({
    String? headerName,
    String? headerDescription,
    String? kbTitle,
    String? kbDescription,
    String? ticketTitle,
    String? ticketDescription,
    String? submitButtonText,
  }) async {
    await methodChannel.invokeMethod('setHomeDashboardContent', {
      'headerName': headerName,
      'headerDescription': headerDescription,
      'kbTitle': kbTitle,
      'kbDescription': kbDescription,
      'ticketTitle': ticketTitle,
      'ticketDescription': ticketDescription,
      'submitButtonText': submitButtonText,
    });
  }

  @override
  Future<void> applyCustomFontFamilyInAndroid({
    required String regular,
    required String medium,
    required String semiBold,
    required String bold,
  }) async {
    await methodChannel.invokeMethod('applyCustomFontFamilyInAndroid', {
      'regular': regular,
      'medium': medium,
      'semiBold': semiBold,
      'bold': bold,
    });
  }
}
