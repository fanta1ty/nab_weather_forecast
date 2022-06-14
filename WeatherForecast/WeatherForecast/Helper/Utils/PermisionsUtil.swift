import Foundation
import Contacts
import UIKit

class PermisionsUtils {
    static let shared = PermisionsUtils()
    init() { }
    
    func requestContactList(completionHandler: @escaping (_ accessGranted: Bool) -> Void) {
        switch CNContactStore.authorizationStatus(for: .contacts) {
        case .authorized:
            completionHandler(true)
        case .denied:
            completionHandler(false)
            Log.d("denied ===>> Show alert")
        case .restricted, .notDetermined:
            CNContactStore().requestAccess(for: .contacts) { granted, _ in
                completionHandler(granted)
            }
        @unknown default: break
        }
    }
}
