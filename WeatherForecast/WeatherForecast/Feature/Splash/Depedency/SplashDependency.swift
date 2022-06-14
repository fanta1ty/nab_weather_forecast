import Foundation
import Swinject

class SplashDependency: Dependency {
    
    override func setup() {
        assembler.apply(assembly: SplashAssemply())
    }
}
