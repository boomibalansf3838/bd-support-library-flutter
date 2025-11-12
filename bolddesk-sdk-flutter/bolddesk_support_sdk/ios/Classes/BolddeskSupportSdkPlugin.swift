import BoldDeskSupportSDK
import Flutter
import UIKit

public class BolddeskSupportSdkPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(
      name: "bolddesk_support_sdk", binaryMessenger: registrar.messenger())
    let instance = BolddeskSupportSdkPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "showHomeDashboard":
      BDSupportSDK.showHomeDashboard()
      result(nil)
    case "showCreateTicket":
      BDSupportSDK.showCreateTicket()
      result(nil)
    case "showKB":
      BDSupportSDK.showKB()
      result(nil)
    case "setLoggingEnabled":
      BDSupportSDK.enableLogging()
      result(nil)
    case "logout":
      BDSupportSDK.logout()
      result(nil)
    case "applyCustomFontFamilyInIOS":
      guard let args = call.arguments as? [String: Any],
        let fontFamily = args["fontFamily"] as? String
      else {
        return
      }
      BDPortalConfiguration.customFontName = fontFamily
      result(nil)
    case "setSystemFontSize":
      guard let args = call.arguments as? [String: Any],
        let enable = args["enable"] as? Bool
      else {
        return
      }
      BDSupportSDK.applySystemFontSize = enable
      result(nil)

    case "applyTheme":
      guard let args = call.arguments as? [String: Any],
        let accentColor = args["accentColor"] as? String,
        let primaryColor = args["primaryColor"] as? String
      else {
        return
      }
      BDSupportSDK.applyTheme(
        accentColor: accentColor,
        primaryColor: primaryColor
      )
      result(nil)
    case "setPreferredTheme":
      guard let args = call.arguments as? [String: Any],
        let themeString = args["theme"] as? String
      else {
        result(["success": false, "message": "Missing theme"])
        return
      }

      let preferredTheme: SDKTheme
      switch themeString.lowercased() {
      case "light":
        preferredTheme = .light
      case "dark":
        preferredTheme = .dark
      default:
        preferredTheme = .system
      }

      BDSupportSDK.setPreferredTheme(preferredTheme)
      result(nil)
    case "initialize":
      guard let args = call.arguments as? [String: Any],
        let appId = args["appId"] as? String,
        let brandUrl = args["brandUrl"] as? String
      else {
        result(["success": false, "message": "Missing arguments"])
        return
      }

      BDSupportSDK.initialize(
        appId: appId,
        brandURl: brandUrl,
        { success in
          result(["success": true, "message": success ?? "Initialized successfully"])
        },
        { error in
          result(["success": false, "message": error ?? "Initialization failed"])
        }
      )

    case "loginWithJWTToken":
      guard let args = call.arguments as? [String: Any],
        let jwtToken = args["jwtToken"] as? String
      else {
        result(["success": false, "message": "Missing arguments"])
        return
      }

      BDSupportSDK.loginWithJWTToken(
        jwtToken: jwtToken ?? "",
        { success in
          result(["success": true, "message": success ?? "Login successfully"])
        },
        { error in
          result(["success": false, "message": error ?? "Login Failed"])
        }
      )
    case "handleNotification":
      if let args = call.arguments as? [String: Any] {
        BDSupportSDK.processRemoteNotification(userInfo: args)
        result(nil)
      } else {
        result(
          FlutterError(
            code: "INVALID_ARGUMENTS", message: "Expected notification data", details: nil))
      }
    case "setFCMRegistrationToken":
      guard let args = call.arguments as? [String: Any],
        let token = args["token"] as? String
      else {
        return
      }
      BDSupportSDK.enablePushNotification(fcmToken: token)
      result(nil)
    case "setHeaderLogo":
      guard let args = call.arguments as? [String: Any],
        let logoURL = args["logoURL"] as? String
      else {
        return
      }
      BDSDKHome.setHeaderLogo(logoURL: logoURL)
      result(nil)
    case "setHomeDashboardContent":
      guard let args = call.arguments as? [String: Any],
        let headerName = args["headerName"] as? String,
        let headerDescription = args["headerDescription"] as? String,
        let kbTitle = args["kbTitle"] as? String,
        let kbDescription = args["kbDescription"] as? String,
        let ticketTitle = args["ticketTitle"] as? String,
        let ticketDescription = args["ticketDescription"] as? String,
        let submitButtonText = args["submitButtonText"] as? String
      else {
        return
      }
      BDSDKHome.setHomeDashboardContent(
        headerName: headerName, headerDescription: headerDescription, kbTitle: kbTitle,
        kbDescription: kbDescription, ticketTitle: ticketTitle, ticketDescription: ticketDescription,
        submitButtonText: submitButtonText)
      result(nil)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
