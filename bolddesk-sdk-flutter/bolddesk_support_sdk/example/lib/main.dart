import 'dart:io';

import 'package:bolddesk_support_sdk/bolddesk_support_sdk.dart';
import 'package:bolddesk_support_sdk_example/firebase_options.dart';
import 'package:bolddesk_support_sdk_example/notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize firebase services
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    sound: true,
    alert: true,
    badge: true,
  );
  // Request Notification permission when user enter into application
  await FirebaseMessaging.instance.requestPermission();
  // Initialize Firebase Messaging services to receive Notifications
  NotificationService.firebaseMessagingInitialize();
  // Get FCM Token Based
  await NotificationService.getFCMToken();

  // Handle notification when app is terminated state (iOS only)
  if (Platform.isIOS) {
    FirebaseMessaging.instance.getInitialMessage().then((message) async {
      if (message != null) {
        BoldDeskSupportSDK.handleIOSNotification(message.data);
      }
    });
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  String generateJwt({required String secretKey, required String email}) {
    // iat in seconds since epoch (UTC)
    final issuedAt = DateTime.now().toUtc().millisecondsSinceEpoch ~/ 1000;

    final jwt = JWT({'email': email, 'name': "", 'iat': issuedAt});

    // Sign with HS256
    final token = jwt.sign(SecretKey(secretKey), algorithm: JWTAlgorithm.HS256);

    return token;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Plugin example app')),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                BoldDeskSupportSDK.showHome();
              },
              child: Text("Show Home"),
            ),

            ElevatedButton(
              onPressed: () {
                BoldDeskSupportSDK.showKB();
              },
              child: Text("Show KB"),
            ),

            ElevatedButton(
              onPressed: () {
                BoldDeskSupportSDK.showCreateTicket();
              },
              child: Text("Show Create Ticket"),
            ),

            ElevatedButton(
              onPressed: () {
                BoldDeskSupportSDK.initialize(
                  "VcVGW+Om90d2ZW4ivuuendHtDS/qqdhZkBk6nzKStotppzqgu7ZMjgnk71+MjgUgQ3698FQybWCzNyey3DLbmw==",
                  "stagingboldsign.bolddesk.com",
                  onSuccess: (message) {
                    print("SDK Initialized Successfully: $message");
                  },
                  onError: (error) {
                    print("SDK Initialization Failed: $error");
                  },
                );
              },
              child: Text("initialize SDK"),
            ),
            ElevatedButton(
              onPressed: () {
                var jwtToken = generateJwt(
                  secretKey:
                      "lHfejZoxxBi6Pe4WOggOgfX6tmngKff9qzFeLmNj4cLep3NW9tYdiJQxJOcC76SinL2KC0sZUo0qRgAKlQGR0g==",
                  email: "somaprasanna.m@syncfusion.com",
                );
                BoldDeskSupportSDK.loginWithJWTToken(
                  jwtToken,
                  onSuccess: (message) {
                    print("SDK Initialized Successfully: $message");
                  },
                  onError: (error) {
                    print("SDK Initialization Failed: $error");
                  },
                );
              },
              child: Text("Login"),
            ),

            ElevatedButton(
              onPressed: () {
                BoldDeskSupportSDK.applyTheme("#FF0000", "#00FF00");
              },
              child: Text("Theme Color Change"),
            ),

            ElevatedButton(
              onPressed: () {
                BoldDeskSupportSDK.setPreferredTheme("system");
              },
              child: Text("ThemeMode"),
            ),

            ElevatedButton(
              onPressed: () {
                BoldDeskSupportSDK.logout();
              },

              child: Text("Logout"),
            ),

            ElevatedButton(
              onPressed: () {
                BoldDeskSupportSDK.applyCustomFontFamilyInIOS(
                  "Times New Roman",
                );
              },
              child: Text("Font Family"),
            ),

            ElevatedButton(
              onPressed: () {
                BoldDeskSupportSDK.setSystemFontSize(false);
              },
              child: Text("Font Size"),
            ),

            ElevatedButton(
              onPressed: () {
                BoldDeskSDKHome.setHeaderLogo(
                  "https://images.google.com/images/branding/googlelogo/2x/googlelogo_light_color_272x92dp.png",
                );
              },
              child: Text("Header Logo"),
            ),

            ElevatedButton(
              onPressed: () {
                BoldDeskSDKHome.setHomeDashboardContent(
                  headerName: "Custom Header",
                  headerDescription: "This is custom header description",
                  kbTitle: "Custom KB Title",
                  kbDescription: "This is custom KB description",
                  ticketTitle: "Custom Ticket Title",
                  ticketDescription: "This is custom Ticket description",
                  submitButtonText: "Send Now",
                );
              },
              child: Text("set custom content"),
            ),

            ElevatedButton(
              onPressed: () {
                BoldDeskSupportSDK.setLoggingEnabled(true);
              },
              child: Text("Set Logging Enabled"),
            ),

            ElevatedButton(
              onPressed: () {
                BoldDeskSupportSDK.applyCustomFontFamilyInAndroid(
                  bold: "dancingscript_bold",
                  semiBold: "dancingscript_semibold",
                  medium: "dancingscript_medium",
                  regular: "dancingscript_regular",
                );
              },
              child: Text("Set Custom Font Family Android"),
            ),

             ElevatedButton(
              onPressed: () {
                BoldDeskSupportSDK.setFCMRegistrationToken("fXI54TkpTruS38JPQ4zGLf:APA91bGHzj-yfZEiJJKPpWYDb0NI4jV7QfwT9qZ8_FRInznrXS9_Pb6NWGjY6KV4Cjec2HjYmmHbepfuZhMuxqEWqjaLGPRCWM9bcdapSij9euFA5v_YM_0");
              },
              child: Text("Set FCM Token"),
            ),
          ],
        ),
      ),
    );
  }
}
