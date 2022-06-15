import Foundation

class AppConfiguration {

    let bundle: Bundle
    
    var serverDomainName: String? {
        return value(for: ConfigurationKey.Url.serverDomainName)
    }
    
    init(bundle: Bundle) {
        self.bundle = bundle
    }
    
    private func value<T>(for key: String) -> T? where T: LosslessStringConvertible {
        guard let value = bundle.object(forInfoDictionaryKey: key) else { return nil }
        switch value {
        case let value as T:
            return value
        case let string as String:
            guard let value = T(string) else { return nil }
            return value
        default:
            return nil
        }
    }
}

// MARK: UrlProvider
extension AppConfiguration: UrlProvider {
    var serverBaseURL: String? {
        return value(for: ConfigurationKey.Url.serverBaseUrl)
    }
}
