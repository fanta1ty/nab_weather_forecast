import Foundation
import Swinject

final class TabbarAssembly: Assembly {
    func assemble(container: Container) {
        container.register(TabbarInteractable.self) { _ in
            return TabbarInteractor(usecases: [])
        }
        
        container.register(TabbarViewModel.self) { resolver in
            guard let interactor =  resolver.resolve(TabbarInteractable.self)
            else { fatalError("cannot resolve TabbarInteractable") }
            
            return TabbarViewModelImpl(interactor: interactor)
        }
    }
}
