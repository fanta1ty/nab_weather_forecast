import Foundation

/// Enum which maps an appropiate symbol which added as prefix for each log message
///
/// - error: Log type error
/// - info: Log type info
/// - debug: Log type debug
/// - verbose: Log type verbose
/// - warning: Log type warning
/// - severe: Log type severe
enum LogEvent: String {
    case e = "[Error] " // error // swiftlint:disable:this identifier_name
    case i = "[Info] " // info // swiftlint:disable:this identifier_name
    case d = "[Debug] " // debug // swiftlint:disable:this identifier_name
    case v = "[Verbose] " // verbose // swiftlint:disable:this identifier_name
    case w = "[Warning] " // warning // swiftlint:disable:this identifier_name
    case s = "[Sever] " // severe // swiftlint:disable:this identifier_name
}

/// Wrapping Swift.print() within DEBUG flag
///
/// - Note: *print()* might cause [security vulnerabilities]
/// (https://codifiedsecurity.com/mobile-app-security-testing-checklist-ios/)
///
/// - Parameter object: The object which is to be logged
///
func print(_ object: Any) {
    // Only allowing in DEBUG mode
    #if DEBUG
    Swift.print(object)
    #elseif MOCK
    Swift.print(object)
    #endif
}

class Log {
    
    static var dateFormat = "hh:mm:ss"
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        return formatter
    }
    
    private static var isLoggingEnabled: Bool {
        #if DEBUG
        return true
        #elseif MOCK
        return true
        #else
        return false
        #endif
    }
    
    // MARK: - Loging methods
    
    /// - Parameters:
    ///   - object: Object or message to be logged
    ///   - filename: File name from where loggin to be done
    ///   - line: Line number in file from where the logging is done
    ///   - column: Column number of the log message
    ///   - funcName: Name of the function from where the logging is done
    class func e( _ object: Any,
                  filename: String = #file,
                  line: Int = #line) {
        if isLoggingEnabled {
            print("\(Date().toString()) \(LogEvent.e.rawValue)[\(sourceFileName(filePath: filename))]:\(line) -> \(object)") // swiftlint:disable:this line_length
        }
    }
    
    /// - Parameters:
    ///   - object: Object or message to be logged
    ///   - filename: File name from where loggin to be done
    ///   - line: Line number in file from where the logging is done
    ///   - column: Column number of the log message
    ///   - funcName: Name of the function from where the logging is done
    class func i ( _ object: Any,
                   filename: String = #file,
                   line: Int = #line) {
        if isLoggingEnabled {
            print("\(Date().toString()) \(LogEvent.i.rawValue)[\(sourceFileName(filePath: filename))]:\(line) -> \(object)") // swiftlint:disable:this line_length
        }
    }
    
    /// - Parameters:
    ///   - object: Object or message to be logged
    ///   - filename: File name from where loggin to be done
    ///   - line: Line number in file from where the logging is done
    ///   - column: Column number of the log message
    ///   - funcName: Name of the function from where the logging is done
    class func d( _ object: Any,
                  filename: String = #file,
                  line: Int = #line) {
        if isLoggingEnabled {
            print("\(Date().toString()) \(LogEvent.d.rawValue)[\(sourceFileName(filePath: filename))]:\(line) -> \(object)") // swiftlint:disable:this line_length
        }
    }
    
    /// - Parameters:
    ///   - object: Object or message to be logged
    ///   - filename: File name from where loggin to be done
    ///   - line: Line number in file from where the logging is done
    ///   - column: Column number of the log message
    ///   - funcName: Name of the function from where the logging is done
    class func v( _ object: Any,
                  filename: String = #file,
                  line: Int = #line) {
        if isLoggingEnabled {
            print("\(Date().toString()) \(LogEvent.v.rawValue)[\(sourceFileName(filePath: filename))]:\(line) -> \(object)") // swiftlint:disable:this line_length
        }
    }
    
    /// - Parameters:
    ///   - object: Object or message to be logged
    ///   - filename: File name from where loggin to be done
    ///   - line: Line number in file from where the logging is done
    ///   - column: Column number of the log message
    ///   - funcName: Name of the function from where the logging is done
    class func w( _ object: Any,
                  filename: String = #file,
                  line: Int = #line) {
        if isLoggingEnabled {
            print("\(Date().toString()) \(LogEvent.w.rawValue)[\(sourceFileName(filePath: filename))]:\(line) -> \(object)") // swiftlint:disable:this line_length
        }
    }
    
    /// - Parameters:
    ///   - object: Object or message to be logged
    ///   - filename: File name from where loggin to be done
    ///   - line: Line number in file from where the logging is done
    ///   - column: Column number of the log message
    ///   - funcName: Name of the function from where the logging is done
    class func s( _ object: Any,
                  filename: String = #file,
                  line: Int = #line) {
        if isLoggingEnabled {
            print("\(Date().toString()) \(LogEvent.s.rawValue)[\(sourceFileName(filePath: filename))]:\(line) -> \(object)") // swiftlint:disable:this line_length
        }
    }
    
    /// Extract the file name from the file path
    ///
    /// - Parameter filePath: Full file path in bundle
    /// - Returns: File Name with extension
    private class func sourceFileName(filePath: String) -> String {
        let components = filePath.components(separatedBy: "/")
        return components.isEmpty ? "" : components.last!
    }
}

internal extension Date {
    func toString() -> String {
        return Log.dateFormatter.string(from: self as Date)
    }
}
