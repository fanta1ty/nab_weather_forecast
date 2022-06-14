import Foundation
import Swinject

final class SupporterAssembly: Assembly {
    func assemble(container: Container) {
        container.register(AppConfiguration.self) { _ -> AppConfiguration in
            return AppConfiguration(bundle: Bundle.main)
        }.inObjectScope(.container)
        
        container.register(Localizable.self) { _ -> Localizable in
            return DefaultLocalization()
        }.inObjectScope(.weak)
        
        container.register(UrlProvider.self) { resolver -> UrlProvider in
            guard let urlProvider = resolver.resolve(AppConfiguration.self)
                else { fatalError("Can not resolve \(AppConfiguration.self)") }
            return urlProvider
        }
    }
}
