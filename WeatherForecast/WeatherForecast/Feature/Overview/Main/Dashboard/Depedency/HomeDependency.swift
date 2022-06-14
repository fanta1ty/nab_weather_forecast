import Foundation

class HomeDependency: Dependency {
    
    override func setup() {
        assembler.apply(assembly: HomeAssemply())
    }
}
