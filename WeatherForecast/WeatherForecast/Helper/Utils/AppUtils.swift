import Foundation
import ContactsUI

class ContactUtils {
    static let shared = ContactUtils()
    init() { }
    func getList() -> [CNContact] {
        let contactStore = CNContactStore()
        let keysToFetch = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
                           CNContactPhoneNumbersKey,
                           CNContactEmailAddressesKey,
                           CNContactThumbnailImageDataKey] as [Any]
        var allContainers: [CNContainer] = []
        do {
            allContainers = try contactStore.containers(matching: nil)
        } catch {
            Log.e(error)
        }
        var results: [CNContact] = []
        for container in allContainers {
            let fetchPredicate = CNContact.predicateForContactsInContainer(withIdentifier: container.identifier)
            do {
                let containerResults =
                    try contactStore
                    .unifiedContacts(matching: fetchPredicate,
                                     keysToFetch: keysToFetch as! [CNKeyDescriptor])// swiftlint:disable:this force_cast
                results.append(contentsOf: containerResults)
            } catch {
                Log.e(error)
            }
        }
        return results
    }
}

class AppUtils {
    class func getBuildInfo() -> String {
        return "V 1.0.0"
    }
    
    static func convertToCountDownTime(inputDate: Double) -> Int {
        let endTimeStamp = Double(inputDate) / 1000.0
        let currentTimeStamp = Double(Date().timeIntervalSince1970)
        
        let countDownTimeStamp = abs(endTimeStamp - currentTimeStamp)
        let countDownDate = Date(timeIntervalSince1970: TimeInterval(countDownTimeStamp))
        let countDownHour = Calendar.current.component(.hour, from: countDownDate)
        let countDownMinute = Calendar.current.component(.minute, from: countDownDate)
        let countDownSecond = Calendar.current.component(.second, from: countDownDate)
        
        return countDownHour * 3600 + countDownMinute * 60 + countDownSecond
    }
}
