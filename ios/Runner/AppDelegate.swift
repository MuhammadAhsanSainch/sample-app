import Flutter
import UIKit
import Firebase
import UserNotifications // <-- Import this for notification permissions

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure()
      
    // Get the FlutterViewController
    let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
      
    // Create the Method Channel
    let notificationBadgeChannel = FlutterMethodChannel(name: "com.futurbyte.barakahbuilder/notificationBadgeChannel",
                                                      binaryMessenger: controller.binaryMessenger) // <-- FIX: Use the controller's binaryMessenger
      
    // Set the Method Call Handler
    notificationBadgeChannel.setMethodCallHandler({
      (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      
      // Use a switch statement to handle multiple methods
      switch call.method {
      case "getNotificationBadge":
        self.getNotificationBadge(result: result)
      case "updateNotificationBadge":
        self.updateNotificationBadge(call: call, result: result) // <-- NEW: Handle the update method
      default:
        result(FlutterMethodNotImplemented)
      }
    })
      
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    override func application(
        _ application: UIApplication,
        didReceiveRemoteNotification userInfo: [AnyHashable : Any],
        fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void
      ) {
        // This forwards the notification data to the Firebase SDK
        Messaging.messaging().appDidReceiveMessage(userInfo)
        
        // Note: The original Objective-C code did not call the completionHandler,
        // which can cause issues. Calling super's implementation is good practice.
        super.application(application, didReceiveRemoteNotification: userInfo, fetchCompletionHandler: completionHandler)
      }
    // Define these at the class level for easy reuse
    let appGroupID = "group.com.futurbyte.barakahbuilder.notificationservice" // <-- Use your App Group ID
    let badgeKey = "notificationBadgeCount"

    private func getNotificationBadge(result: FlutterResult) {
        if let defaults = UserDefaults(suiteName: appGroupID) {
            let badgeCount = defaults.integer(forKey: badgeKey)
            result(badgeCount)
        } else {
            result(FlutterError(code: "UNAVAILABLE", message: "Could not access shared UserDefaults", details: nil))
        }
    }

    private func updateNotificationBadge(call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? [String: Any],
              let count = args["count"] as? Int else {
          result(FlutterError(code: "INVALID_ARGUMENT", message: "Argument 'count' is missing or not an Int", details: nil))
          return
        }

        // Set the badge on the app icon directly
        DispatchQueue.main.async {
            UIApplication.shared.applicationIconBadgeNumber = count
        }
        
        // Also save this count to our shared UserDefaults so the extension knows about it
        if let defaults = UserDefaults(suiteName: appGroupID) {
            defaults.set(count, forKey: badgeKey)
            result(nil) // Success
        } else {
            result(FlutterError(code: "UNAVAILABLE", message: "Could not access shared UserDefaults to save count", details: nil))
        }
        // Note: Requesting permission is still good, but you can do it once at app startup
        // rather than in every call if you prefer.
    }
}
