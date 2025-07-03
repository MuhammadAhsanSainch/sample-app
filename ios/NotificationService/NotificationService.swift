import UserNotifications

class NotificationService: UNNotificationServiceExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?

    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
        
        if let bestAttemptContent = bestAttemptContent {
            // --- BADGE INCREMENT LOGIC ---
            
            // 1. Use a shared UserDefaults suite to communicate between the app and the extension.
            // Replace "group.com.futurbyte.barakahbuilder" with your actual App Group ID.
            // You must enable "App Groups" in your project's "Signing & Capabilities" for both your main app and the extension.
            let defaults = UserDefaults(suiteName: "group.com.futurbyte.barakahbuilder.notificationservice")
            let badgeKey = "notificationBadgeCount"
            
            // 2. Get the current count, defaulting to 0 if not set.
            var currentBadgeCount = defaults?.integer(forKey: badgeKey) ?? 0
            
            // 3. Increment the count.
            currentBadgeCount += 1
            
            // 4. Set the new count on the notification itself.
            bestAttemptContent.badge = NSNumber(value: currentBadgeCount)
            
            // 5. Save the new count back to UserDefaults for the next notification.
            defaults?.set(currentBadgeCount, forKey: badgeKey)
            
            // --- END OF LOGIC ---
            
            // 6. Deliver the modified notification.
            contentHandler(bestAttemptContent)
        }
    }
    
    override func serviceExtensionTimeWillExpire() {
        // Called just before the extension will be terminated by the system.
        // Use this as an opportunity to deliver the original notification content.
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }
}
