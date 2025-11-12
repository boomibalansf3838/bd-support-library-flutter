package com.bolddesksupportsdk.bolddesk_support_sdk

import android.content.Context
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import com.syncfusion.bolddeskmobileSDK.BoldDeskSupportSDK
import com.syncfusion.bolddeskmobileSDK.BoldDeskSDKHome
import com.syncfusion.bolddeskmobileSDK.R

/** BolddeskSupportSdkPlugin */
class BolddeskSupportSdkPlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private lateinit var context: Context

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "bolddesk_support_sdk")
        channel.setMethodCallHandler(this)
        context = flutterPluginBinding.applicationContext
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        if (call.method == "initialize") {
            val appId = call.argument<String>("appId") ?: ""
            val brandUrl = call.argument<String>("brandUrl") ?: ""
            val onSuccessCallback: ((String) -> Unit)? = { successMessage ->
               result.success(mapOf("success" to true, "message" to successMessage))
            }

            val onErrorCallback: ((String) -> Unit)? = { errorMessage ->
               result.success(mapOf("success" to false, "message" to errorMessage))
            }
            try {
                BoldDeskSupportSDK.initialize(context, appId, brandUrl, onSuccessCallback, onErrorCallback)
            } catch (e: Exception) {
                result.error("INITIALIZATION_FAILED", e.message, null)
            }
        } else if (call.method == "loginWithJWTToken") {
             val jwtToken = call.argument<String>("jwtToken") ?: ""
             val onSuccessCallback: ((String) -> Unit)? = { successMessage ->
               result.success(mapOf("success" to true, "message" to successMessage))
            }

            val onErrorCallback: ((String) -> Unit)? = { errorMessage ->
               result.success(mapOf("success" to false, "message" to errorMessage))
            }
            try {
                BoldDeskSupportSDK.loginWithJWTToken(context, jwtToken, onSuccessCallback, onErrorCallback)
            } catch (e: Exception) {
                result.error("LOGIN_FAILED", e.message, null)
            }
        } else if (call.method == "logout") {
            BoldDeskSupportSDK.logout(context)
            result.success("Logged out Successfully")
        } else if (call.method == "showHomeDashboard") {
            BoldDeskSupportSDK.showHomeDashboard(context)
            result.success("Opened HomePage Successfully")
        } else if (call.method == "showKB") {
            BoldDeskSupportSDK.showKB(context)
            result.success("Opened KnowledgeBase Successfully")
        } else if (call.method == "showCreateTicket") {
            BoldDeskSupportSDK.showCreateTicket(context)
            result.success("Opened create ticket page Successfully")
        } else if (call.method == "showNotification") {
            val messageData = call.argument<Map<String, String>>("body") ?: emptyMap()
            val icon = call.argument<String>("icon") ?: ""
            val iconResId = resolveIcon(context, icon)
            try {
                BoldDeskSupportSDK.handlePushNotifications(context, messageData, iconResId)
                result.success("Notification shown Successfully")
            } catch (e: Exception) {
                result.error("NOTIFICATION_FAILED", e.message, null)
            }
        } else if (call.method == "setFCMRegistrationToken") {
            val token = call.argument<String>("token") ?: ""
            BoldDeskSupportSDK.setFCMRegistrationToken(context,token)
            result.success("Token Set Successfully")
        } else if (call.method == "setLoggingEnabled"){
            val isEnabled = call.argument<Boolean>("enable") ?: false
            BoldDeskSupportSDK.setLoggingEnabled(isEnabled)
            result.success("Logging set Successfully")
        } else if (call.method == "applyTheme") {
            val primaryColor = call.argument<String>("primaryColor") ?: ""
            val accentColor = call.argument<String>("accentColor") ?: ""
            BoldDeskSupportSDK.applyTheme(primaryColor, accentColor)
            result.success("Theme applied Successfully")
        } else if (call.method == "setPreferredTheme") {
            val theme = call.argument<String>("theme") ?: ""
            BoldDeskSupportSDK.setPreferredTheme(theme)
            result.success("Theme applied Successfully")
        }else if (call.method == "setSystemFontSize"){
            val isEnabled = call.argument<Boolean>("enable") ?: false
            BoldDeskSupportSDK.setSystemFontSize(isEnabled)
            result.success("Logging set Successfully")
        }else if (call.method == "applyCustomFontFamilyInAndroid") {
            val regular = call.argument<String>("regular") ?: ""
            val medium = call.argument<String>("medium") ?: ""
            val semiBold = call.argument<String>("semiBold") ?: ""
            val bold = call.argument<String>("bold") ?: ""
            try {
                // Dynamically find the resource ID for each font name
                val regularId = getFontResourceId(context,regular)
                val mediumId = getFontResourceId(context,medium)
                val semiBoldId = getFontResourceId(context,semiBold)
                val boldId = getFontResourceId(context,bold)

                // Call YOUR Android SDK with the integer IDs you just found
                BoldDeskSupportSDK.applyCustomFontFamily(
                    regular = regularId,
                    medium = mediumId,
                    semiBold = semiBoldId,
                    bold = boldId
                )
                result.success(null)

            } catch (e: Exception) {
                result.error("FONT_NOT_FOUND", e.message, null)
            }
        } else if (call.method == "setHeaderLogo"){
            val logoUrl = call.argument<String>("logoURL") ?: ""
            BoldDeskSDKHome.setHeaderLogo(logoUrl)
            result.success("Logo set Successfully")
        }else if (call.method == "setHomeDashboardContent"){
             val submitButtonText = call.argument<String>("submitButtonText") ?: ""
              val ticketDescription = call.argument<String>("ticketDescription") ?: ""
               val ticketTitle = call.argument<String>("ticketTitle") ?: ""
                val kbDescription = call.argument<String>("kbDescription") ?: ""
                 val kbTitle = call.argument<String>("kbTitle") ?: ""
                  val headerDescription = call.argument<String>("headerDescription") ?: ""
                   val headerName = call.argument<String>("headerName") ?: ""

            BoldDeskSDKHome.setHomeDashboardContent(
                 headerName,
                 headerDescription,
                 kbTitle,
                 kbDescription,
                 ticketTitle,
                 ticketDescription,
                 submitButtonText,  
            )
            result.success("Content set Successfully")
        }
        else {
            result.notImplemented()
        }
    }

    private fun getFontResourceId(context: Context, fontName: String): Int {
        // This is the magic: It looks for a resource of type "font" with the given name
        // in the application's package.
        val resourceId = context.resources.getIdentifier(fontName, "font", context.packageName)

        if (resourceId == 0) {
            // This error is critical for debugging!
            throw Exception("Font resource '$fontName' not found. " +
                "Ensure it's in pubspec.yaml and the filename is correct.")
        }
        return resourceId
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    private fun resolveIcon(context: Context, iconName: String): Int {
        // Try to resolve from drawable resources
        val resId = context.resources.getIdentifier(
            iconName,
            "drawable",
            context.packageName
        )

        // Return resolved ID or default launcher icon
        return if (resId != 0) resId else android.R.drawable.ic_dialog_info
    }
}
