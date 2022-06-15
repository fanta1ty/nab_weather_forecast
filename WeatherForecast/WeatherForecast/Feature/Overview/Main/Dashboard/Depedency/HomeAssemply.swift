import Foundation
import Swinject
// swiftlint:disable function_body_length
// swiftlint:disable cyclomatic_complexity
final class HomeAssemply: Assembly {
    func assemble(container: Container) {
        
        container.register(HomeViewModel.self) { resolver in
            guard let interactor = resolver.resolve(HomeInteractable.self)
            else { fatalError("can't resolve HomeInteractable") }
            
            return HomeViewModelImpl(interactor: interactor)
        }
        
        container.register(HomeInteractable.self) { resolver in
            guard let forecastUseCase = resolver.resolve(ForecastUseCase.self)
            else { fatalError("can't resolve ForecastUseCase") }
            
            return HomeInteractor(forecastUseCase: forecastUseCase)
        }
    }
}
