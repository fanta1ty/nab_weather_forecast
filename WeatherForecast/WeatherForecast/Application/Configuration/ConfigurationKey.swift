public enum ConfigurationKey {
    enum Url {
        static let serverDomainName = "SERVER_DOMAIN_NAME"
        #if DEBUG_CONFIG
        static let serverBaseUrl = "SERVER_DEBUG_BASE_URL"
        #else
        static let serverBaseUrl = "SERVER_BASE_URL"
        #endif
        static let serverMockBaseUrl = "SERVER_MOCK_BASE_URL"
    }
}
