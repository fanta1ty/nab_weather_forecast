import Foundation
import Swinject

class StyleAssembly: Assembly {
    func assemble(container: Container) {
        container.register(FontStyleProvider.self) { _ -> FontStyleProvider in
            return ProjectStaticFontStyleProvider()
        }.inObjectScope(.container)
        
        container.register(ProjectFontServicing.self) { resolver -> ProjectFontServicing in
            guard let fontProvider = resolver.resolve(FontStyleProvider.self)
                else { fatalError("can not resolve \(FontStyleProvider.self)") }
            return ProjectFontService(fontStyleProvider: fontProvider)
        }
        .initCompleted({ (_, tymeFontServicing) in
            ProjectFontService.shared = tymeFontServicing
        })
        .inObjectScope(.container)
        
        container.register(ProjectStyle.self) { resolver -> ProjectStyle in
            guard let fontServicing = resolver.resolve(ProjectFontServicing.self)
                else { fatalError("can not resolve \(ProjectFontServicing.self)") }
            return ProjectStyle(fontService: fontServicing)
        }.inObjectScope(.container)
    }
}
