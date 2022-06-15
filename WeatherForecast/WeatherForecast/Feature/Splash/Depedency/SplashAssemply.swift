import Foundation
import Swinject

final class SplashAssemply: Assembly {
    func assemble(container: Container) {
        container.register(SplashViewModel.self) { _ in
            return SplashViewModelImpl(interactor: nil)
        }
    }
}
