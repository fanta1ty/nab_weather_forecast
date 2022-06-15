import Foundation
import Swinject

final class RepositoryAssembly: Assembly {
    func assemble(container: Container) {
        // MARK: - Forecast Section
        container.register(WeatherForecastRepository.self) { resolver in
            guard let networking = resolver.resolve(Networking.self) else {
                fatalError("can't resolve Networking")
            }
            
            return WeatherForecastRepositoryImpl(networking: networking)
        }
    }
}
