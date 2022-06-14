import Foundation
import Swinject

final class RootDependency: Dependency {
    override func setup() {
        let networkAssembly = NetworkAssembly()
        let repositoryAssembly = RepositoryAssembly()
        let usecaseAssembly = UsecaseAssembly()
        let supporterAssembly = SupporterAssembly()
        let styleAssembly = StyleAssembly()
        
        assembler.apply(assemblies: [networkAssembly,
                                     repositoryAssembly,
                                     usecaseAssembly,
                                     supporterAssembly,
                                     styleAssembly])
    }
}
