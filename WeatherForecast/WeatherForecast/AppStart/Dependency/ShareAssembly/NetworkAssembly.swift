import Foundation
import Swinject

final class NetworkAssembly: Assembly {
    func assemble(container: Container) {
        container.register(Networking.self) { resolver -> Networking in
            guard let appConfiguration = resolver.resolve(UrlProvider.self),
                let channelUrl = appConfiguration.serverBaseURL
                else { fatalError("channelUrl is not provided") }
            
            guard let networkClient = NetworkClient(endPoint: channelUrl) else {
                 fatalError("Initialize NetworkClient failure")
            }
            
            return networkClient
        }.inObjectScope(.container)
    }
}
