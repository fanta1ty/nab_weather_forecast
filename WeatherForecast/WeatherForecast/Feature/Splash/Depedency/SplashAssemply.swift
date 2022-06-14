import Foundation
import Swinject

final class SplashAssemply: Assembly {
    func assemble(container: Container) {
        container.register(SplashInteractable.self) { _ -> SplashInteractable in
            return SplashInteractor(usecases: [])
        }
        
        container.register(SplashViewModel.self) { resolver -> SplashViewModel in
            guard let interactor =  resolver.resolve(SplashInteractable.self)
            else { fatalError("cannot resolve SplashInteractable") }
            
            return SplashViewModelImpl(interactor: interactor)
        }
    }
}
