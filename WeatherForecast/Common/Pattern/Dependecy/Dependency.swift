import Foundation
import Swinject

class Dependency {
    
    var assembler: Assembler
    
    var resolver: Resolver {
        return assembler.resolver
    }
    
    init() {
        assembler = Assembler()
        setup()
    }
    
    init(parent: Dependency) {
        assembler = Assembler(parentAssembler: parent.assembler)
        setup()
    }
    
    func setup() {}
    
    func resolve<T>(_ type: T.Type) -> T {
        guard let instance = resolver.resolve(T.self)
            else { fatalError("cannot resolve \(T.self)") }
        return instance
    }
    
    func resolve<T, Arg>(_ type: T.Type, argument: Arg) -> T {
        guard let instance = resolver.resolve(T.self, argument: argument)
            else { fatalError("cannot resolve \(T.self)") }
        return instance
    }

    func resolve<T, Arg1, Arg2>(_ type: T.Type, arguments arg1: Arg1, arg2: Arg2) -> T {
        guard let instance = resolver.resolve(T.self, arguments: arg1, arg2)
            else { fatalError("cannot resolve \(T.self)") }
        return instance
    }
}
