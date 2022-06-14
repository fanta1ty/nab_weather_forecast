import Foundation
import Swinject

class TabbarDependency: Dependency {
    override func setup() {
        assembler.apply(assembly: TabbarAssembly())
    }
}
