import Foundation
import Swinject

final class TabbarAssembly: Assembly {
    func assemble(container: Container) {
        container.register(TabbarViewModel.self) { _ in
            return TabbarViewModelImpl(interactor: nil)
        }
    }
}
