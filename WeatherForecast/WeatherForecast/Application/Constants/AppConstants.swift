import UIKit

public enum ViewTags {
    static let loadingView = 1
}

public enum ValidationConstants {
    static let emailPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
}

public enum AppConstants {
    enum ObjectKey {
        static let badgeCartNumber = "badgeCartNumber"
    }
    
    enum Key {
        public static let loginKey = "loginKey"
        public static let credentialKey = "credentialKey"
        public static let phoneKey = "phoneKey"
    }
    
    enum General {
        static let apiCallTimeout = 60
    }
    
    enum DateFormat {
        static let hourMinuteDayMonthYear = "hh:mm | dd/MM/yyyy"
        static let yearMothdateHour = "yyyy-MMM-dd HH:mm:ss"
        static let dayMonthYearHour = "dd MMM yyyy, HH:mm"
        static let dayMonthYear = "dd MMM yyyy"
        static let monthYear = "MMM yyyy"
    }
    
    enum VNPay {
        static let title = "VnPay"
        static let tmnCode = "APPNUTY1"
        static let txnRef = "vnp_TxnRef"
    }
}
