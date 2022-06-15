import Foundation
import Swinject

final class UsecaseAssembly: Assembly {
    func assemble(container: Container) {
        // MARK: - Forecast Section
        container.register(ForecastUseCase.self) { resolver in
            guard let repository = resolver.resolve(WeatherForecastRepository.self)
            else { fatalError("can't resolve WeatherForecastRepository") }
            
            return ForecastUseCaseImpl(repository: repository)
        }
    }
}
