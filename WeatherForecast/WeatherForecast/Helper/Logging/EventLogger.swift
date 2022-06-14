import Foundation

class EventLogger {
    /// Log a handled non-fatal exception
    class func logException(_ error: Error) {
        Log.d("Catched error exception: \(error.localizedDescription)")
    }

    private class func log(_ string: String) {
        
    }

    class func log(screen: String) {
        log("User is located at \(screen) Screen")
    }

    /// Log a status of feature
    class func log(feature: String, status: String) {
        log("Feature \(feature) was \(status)")
    }

    /// Log an event
    class func log(event: String) {
        log("Event: \(event)")
    }
}
